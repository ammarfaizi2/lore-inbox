Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313754AbSDZJxH>; Fri, 26 Apr 2002 05:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313763AbSDZJxG>; Fri, 26 Apr 2002 05:53:06 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:7943 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S313754AbSDZJxG>;
	Fri, 26 Apr 2002 05:53:06 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.10 UTS_VERSION 
In-Reply-To: Your message of "Fri, 26 Apr 2002 09:33:44 +0200."
             <3CC902D8.4070604@evision-ventures.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Date: Fri, 26 Apr 2002 19:52:53 +1000
Message-ID: <13641.1019814773@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Apr 2002 09:33:44 +0200, 
Martin Dalecki <dalecki@evision-ventures.com> wrote:
>Make sure UTS_VERSION is allways in "C" locale.
>Without it you will get (please note the day of week):
>
>~# export LANG=en_US
>~# uname -a
>Linux rosomak.prv 2.5.10 #1 pi± kwi 26 09:31:52 CEST 2002 i686 unknown
>~#

Why is that a problem?  If a user wants a kernel uname in their local
language, kbuild has no objection.  I need LC_COLLATE=C to get a
consistent filename ordering for kbuild but everything else, including
build messages, date and time can be local.

