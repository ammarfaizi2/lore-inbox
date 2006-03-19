Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbWCSLlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWCSLlh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 06:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWCSLlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 06:41:36 -0500
Received: from smtp6.wanadoo.fr ([193.252.22.25]:8122 "EHLO smtp6.wanadoo.fr")
	by vger.kernel.org with ESMTP id S932086AbWCSLlg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 06:41:36 -0500
X-ME-UUID: 20060319114135178.2B8541C001CA@mwinf0604.wanadoo.fr
To: jengelh@linux01.gwdg.de
Subject: Re: [patch 1/1] consolidate TRUE and FALSE
X-IlohaMail-Blah: xav@awak
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.14 (On: awak.dyndns.org)
Message-ID: <410fpjOB.1142768509.8089710.xav@awak>
In-Reply-To: <Pine.LNX.4.61.0603182238140.4492@yvahk01.tjqt.qr>
From: "Xavier Bestel" <xavier.bestel@free.fr>
Bounce-To: "Xavier Bestel" <xavier.bestel@free.fr>
Cc: "Andrew Morton" <akpm@osdl.org>,
       "viro@ftp.linux.org.uk" <viro@ftp.linux.org.uk>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "aia21@cantab.net" <aia21@cantab.net>,
       "len.brown@intel.com" <len.brown@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Date: Sun, 19 Mar 2006 12:41:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Le 18/3/2006, "Jan Engelhardt" <jengelh@linux01.gwdg.de> a écrit:

>>
>>Isn't there a runtime cost converting all "non-false" values to a unique "true" (i.e. converting non-zero values to one) ?
>>
>
>Somewhat. The answer is "yes, but depends on usage". If you just
>write
>
>	_Bool x = filthy_action();
>	if(x)
>
>Then the compiler is smart enough to optimize 'x' away if it is not used
>somewhere else, therefore we do not pay a price for converting the return
>type of filthy_action (=int) to a _Bool.

Actually I find this behavior very good

     Xavier

