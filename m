Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268204AbUHNIFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268204AbUHNIFg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 04:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268203AbUHNIFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 04:05:23 -0400
Received: from everest.2mbit.com ([24.123.221.2]:53165 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S268200AbUHNIFG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 04:05:06 -0400
Message-ID: <411DC78C.7020303@greatcn.org>
Date: Sat, 14 Aug 2004 16:04:28 +0800
From: Coywolf Qi Hunt <coywolf@greatcn.org>
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
References: <20040813192804.GA10486@mars.ravnborg.org> <20040813194928.GG10556@mars.ravnborg.org>
In-Reply-To: <20040813194928.GG10556@mars.ravnborg.org>
X-Scan-Signature: 9f07f232fbbd9fb152858f6cdece527c
X-SA-Exim-Connect-IP: 218.24.184.185
X-SA-Exim-Mail-From: coywolf@greatcn.org
Subject: Re: [7/12] kbuild: Separate out host-progs handling
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
	*  3.0 RCVD_IN_AHBL_CNKR RBL: AHBL: sender is listed in the AHBL China/Korea blocks
	*      [218.24.184.185 listed in cnkrbl.ahbl.org]
X-SA-Exim-Version: 4.0+cvs20040712 (built Mon, 09 Aug 2004 23:30:37 -0500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:

># This is a BitKeeper generated diff -Nru style patch.
>#
># ChangeSet
>#   2004/08/10 20:09:55+02:00 sam@mars.ravnborg.org 
>#   kbuild: Separate out host-progs handling
>#   
>#   Concentrating all host-progs functionality in one file made a more
>#   readable Makefile.lib - and allow for potential reuse of host-progs
>#   functionality.
>#   Processing of host-progs related stuff are avoided when no host-progs are specified. 
>#   
>#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
># 
># scripts/Makefile.host
>#   2004/08/10 20:09:38+02:00 sam@mars.ravnborg.org +152 -0
># 
># scripts/Makefile.lib
>#   2004/08/10 20:09:38+02:00 sam@mars.ravnborg.org +0 -49
>#   Move host-progs functionality to scripts/Makefile.host
># 
># scripts/Makefile.host
>#   2004/08/10 20:09:38+02:00 sam@mars.ravnborg.org +0 -0
>#   BitKeeper file /home/sam/bk/kbuild/scripts/Makefile.host
># 
># scripts/Makefile.build
>#   2004/08/10 20:09:38+02:00 sam@mars.ravnborg.org +5 -84
>#   Move host-progs functionality to scripts/Makefile.host
># 
>diff -Nru a/scripts/Makefile.build b/scripts/Makefile.build
>--- a/scripts/Makefile.build	2004-08-13 21:08:23 +02:00
>+++ b/scripts/Makefile.build	2004-08-13 21:08:23 +02:00
>@@ -14,6 +14,11 @@
> 
> include scripts/Makefile.lib
> 
>+# Do not include host-progs rules unles needed
>  
>

A typo: unless


-- 
Coywolf Qi Hunt
Homepage http://greatcn.org/~coywolf/
Admin of http://GreatCN.org and http://LoveCN.org

