Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261830AbUKHJjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbUKHJjc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 04:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbUKHJi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 04:38:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:33727 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261802AbUKHJfl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 04:35:41 -0500
Date: Mon, 8 Nov 2004 10:35:38 +0100 (MET)
From: "Alexander Stohr" <Alexander.Stohr@gmx.de>
To: linux-kernel@vger.kernel.org, kai@germaschewski.name, sam@ravnborg.org
MIME-Version: 1.0
Subject: Re: [PATCH] fix for pseudo symbol swapping with scripts/kallsyms - linu
 Re: [PATCH] fix for pseudo symbol swapping with scripts/kallsyms - linux-2.6.10-rc1-bk12 & gcc 3.4.2
X-Priority: 3 (Normal)
X-Authenticated: #15156664
Message-ID: <13418.1099906538@www39.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam,

i tried out your 2nd patch in a "prooven to be bad" configuration.
The extra ALIGN(8) statement caused the listed symbols 
beeing swapped on the first and any further ld cycle. 
In other words the consecutive checks did succeed.

For completeness here is a short excerpt of the System.map:

c03495a0 T __down                                                           
   
c03495a0 T __sched_text_start                                               
   
c0349680 T __down_interruptible                                             
   
c034979c T __down_failed

Thanks for your assistance, lets hope that solution will
make it into the bitkeeper repository in the not so far future.

-Alex.

> This patch is better - we cannot define sections within sections.         
 
>                                                                           
 
> Sam

-- 
Geschenkt: 3 Monate GMX ProMail + 3 Top-Spielfilme auf DVD
++ Jetzt kostenlos testen http://www.gmx.net/de/go/mail ++

