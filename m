Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262846AbVCJTQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262846AbVCJTQf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 14:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263038AbVCJTLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 14:11:42 -0500
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:38557 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S262998AbVCJS6Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 13:58:16 -0500
Message-ID: <00b701c525a3$128c2ac0$6a004b0a@charlemagne>
From: "Nate Edel" <mramfs@sfchat.org>
To: "Jason Luo" <abcd.bpmf@gmail.com>,
       "Arjan van de Ven" <arjan@infradead.org>
Cc: <linux-kernel@vger.kernel.org>
References: <c4b38ec4050310001061c62b9d@mail.gmail.com> <20050310081634.GA29516@taniwha.stupidest.org> <c4b38ec40503100049190d5498@mail.gmail.com> <1110445030.6291.57.camel@laptopd505.fenrus.org>
Subject: Re: Can I get 200M contiguous physical memory?
Date: Thu, 10 Mar 2005 10:57:54 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="Windows-1252";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Arjan van de Ven" <arjan@infradead.org>
To: "Jason Luo" <abcd.bpmf@gmail.com>
>> A data acquisition card. In DMA mode, the card need 200M contiguous
>> memory for DMA.
>
> (or want to reserve memory at the boot commandline and then do really
> really evil hacks)

Such as booting the machine with "mem=(real memory - 200)M" and then 
just doing an ioremap of the top 200M of memory.

It's not the most elegant way of doing things given that it requires 
user intervention at boot time, but I'm not sure it counts as a "really 
evil hack."  Code-wise it's very simple - there's sample code in a 
couple of the in-RAM MTD(*) drivers you can use as a model. I'm not sure 
if this method will translate easily to non-x86 platforms if that's an 
issue.

(* /drivers/mtd/devices/slram.c and /drivers/mtd/devices/mtdram.c ; I'm 
not sure which of these is more up to date.) 

