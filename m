Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262265AbVAIG4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbVAIG4i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 01:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262266AbVAIG4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 01:56:38 -0500
Received: from out007pub.verizon.net ([206.46.170.107]:33198 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S262265AbVAIG4d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 01:56:33 -0500
Message-ID: <41E0D5B2.7030106@cwazy.co.uk>
Date: Sun, 09 Jan 2005 01:56:50 -0500
From: Jim Nelson <james4765@cwazy.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
Subject: Re: ERROR: [PATCH] moxa: Update status of Moxa Smartio driver
References: <200501082329.j08NT873032639@hera.kernel.org> <1105232081.12028.23.camel@localhost.localdomain>
In-Reply-To: <1105232081.12028.23.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [209.158.220.243] at Sun, 9 Jan 2005 00:56:31 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> This changeset is incorrect. The "1.8" version is for the Moxa mxser
> driver. Moxa haven't released any 2.6 driver for the ancient "smartio"
> hardware. (Checked this while fixing mxser).
> 
> In the mxser case that change and update has now been done.
> 
> Please revert this changeset.
> 
> Alan (with tty layer hat on)
> 
> 

Actually, per

http://web4.moxa.com/support/download.asp#mxser.tgz

the mxser driver supports the smartio boards - and from the 1.8 mxser package 
readme.txt:

    The Smartio/Industio/UPCI family Linux driver supports following multiport
    boards.
 

     - 2 ports multiport board
         CP-102U, CP-102UL
         CP-132U-I, CP-132UL,
         CP-132, CP-132I, CP132S, CP-132IS,
         CI-132, CI-132I, CI-132IS,
         (C102H, C102HI, C102HIS, C102P, CP-102, CP-102S)
 

     - 4 ports multiport board
         CP-104UL, CP-104JU,
         CP-134U, CP-134U-I
         C104H/PCI, C104HS/PCI,
         CP-114, CP-114I, CP-114S, CP-114IS,
         C104H, C104HS,
         CI-104J, CI-104JS
         CI-134, CI-134I, CI-134IS,
         (C114HI, CT-114I, C104P)
 

     - 8 ports multiport board
         CP-118U
         CP-168U,
         C168H/PCI,
         C168H, C168HS,
         (C168P)

and Documentation/moxa-smartio says:

    The Smartio family Linux driver, Ver. 1.1, supports following multiport
    boards.

     -C104P/H/HS, C104H/PCI, C104HS/PCI, CI-104J 4 port multiport board.
     -C168P/H/HS, C168H/PCI 8 port multiport board.

Granted, the mxser driver supports many more boards - but it also supports the 
boards mentioned in the smartio driver.

This just means that the smartio driver needs to be marked "obsolete" if mxser is 
merged.  Not that I'm complaining - it's a bit of a mess.

Jim

> 
>>ChangeSet 1.2371, 2005/01/08 14:09:24-08:00, james4765@gmail.com
> 
> 
>>+***NOTE*** - The driver included in the kernel is not maintained by Moxa.  They
>>+have a version 1.8 driver available from:
>>+
>>+http://www.moxa.com
>>+
>>+that works with 2.6 kernels.  Currently, Moxa has no plans to have their updated
>>+driver merged into the kernel.
>>+
>>+James Nelson <james4765@gmail.com> - 12-12-2004
>>+
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

