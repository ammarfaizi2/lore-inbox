Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267487AbUH0UId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267487AbUH0UId (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 16:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267538AbUH0UId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 16:08:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62858 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267487AbUH0Tqh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 15:46:37 -0400
Message-ID: <412F8F93.2010008@pobox.com>
Date: Fri, 27 Aug 2004 15:46:27 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: peter.schaefer@gmx.de
CC: linux-kernel@vger.kernel.org
Subject: Re: [libata - SII3112] 'Virtual' bad blocks?
References: <412F8996.4020300@gmx.de>
In-Reply-To: <412F8996.4020300@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Schaefer wrote:
> Hello!
> 
> I'm using an Epox EP-8HDA3+ Athlon64 Motherboard with
> VIA K8T800 chipset as a file server running 24/7.
> 
> The box is running since 2.6.1 and was a long time rock
> solid on 2.6.4. Problems with the VIA RHINE ethernet let
> me switch to 2.6.7 and now 2.6.8.
> 
> The board has four on-board SATA ports, two provided by
> the chipset and two provided by a Silicon Image 3112 chip.
> I'm running a RAID5 array with three disks - two on the
> chipset and one on the Silicon Image controller.
> 
> For the chipset ports the standard VIA IDE driver is used
> (with SATA support). For the SI disk i'm using the libata
> driver.
> 
> Unfortunately it's exactly this disk which give me headache
> now (it started with 2.6.7) - see logs below.
> 
> I might add that those errors aren't really bad blocks -
> after each occurence i made a full sector scan with
> Western Digital's MS-DOS-based "Data Live Guard" which
> revealed no errors. However, i had to plug the disk to
> one of the VIA ports for the tests (otherwise the tool
> didn't detect the disk).
> 
> Another thing to add is that i have activated CPU
> frequency scaling with powernowd in about the same
> timeframe (to use Cool&Quiet during times of no activity).
> But i doubt that's the reason for this?!
> 
> Do i have to worry (and yes, i know that SATA is dirt
> cheap crap)?

The version of libata you have always reports errors -- be they 
controller errors, cable errors, or disk errors -- as either a read or 
write error.

Alan Cox submitted code that makes the errors more specific, rather than 
treating them all as disk errors.

You have either a flaky controller, flaky cable, or flaky disk, one of 
the three.

	Jeff


