Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274490AbRITNh1>; Thu, 20 Sep 2001 09:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274491AbRITNhT>; Thu, 20 Sep 2001 09:37:19 -0400
Received: from web12305.mail.yahoo.com ([216.136.173.103]:44809 "HELO
	web12305.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S274490AbRITNhM>; Thu, 20 Sep 2001 09:37:12 -0400
Message-ID: <20010920133735.38875.qmail@web12305.mail.yahoo.com>
Date: Thu, 20 Sep 2001 15:37:35 +0200 (CEST)
From: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Subject: Re: [PATCH] Make kernel build numbers work again (was: Re: Cannot compile 2.4.10pre12aa1 with 2.95.2 on
To: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
        rmk@arm.linux.org.uk
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

Why not simply something like this :

newversion:
-  . scripts/mkversion > .version
+  echo $$[`cat .version 2>/dev/null`+1] > .version

The shell evaluates the `cat` expression before it
writes to
".version", so there's no temp file needed anymore.

Comments ?

Willy


___________________________________________________________
Do You Yahoo!? -- Un e-mail gratuit @yahoo.fr !
Yahoo! Courrier : http://fr.mail.yahoo.com
