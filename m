Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbTGAM7m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 08:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbTGAM7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 08:59:42 -0400
Received: from ip252-142.choiceonecom.com ([216.47.252.142]:50704 "EHLO
	explorer.reliacomp.net") by vger.kernel.org with ESMTP
	id S262319AbTGAM7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 08:59:38 -0400
Message-ID: <3F0188FE.90603@cendatsys.com>
Date: Tue, 01 Jul 2003 08:13:34 -0500
From: Edward King <edk@cendatsys.com>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marek Michalkiewicz <marekm@amelek.gda.pl>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.21 IDE problems (lost interrupt, bad DMA status)
References: <20030630221542.GA17416@alf.amelek.gda.pl>
In-Reply-To: <20030630221542.GA17416@alf.amelek.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Marek Michalkiewicz wrote:

>Hi,
>
>After upgrading the kernel from 2.4.20 to 2.4.21, sometimes I see
>the following messages:
>
>hda: dma_timer_expiry: dma status == 0x24
>hda: lost interrupt
>hda: dma_intr: bad DMA status (dma_stat=30)
>hda: dma_intr: status=0x50 { DriveReady SeekComplete }
>
>It happens especially when there is a lot of disk I/O (which stops
>for a few seconds when these messages appear), with three different
>disks (very unlikely they all decided to die at the same time...),
>  
>

Are you using software raid or devfs?

I was losing interrupts and disabling devfs removed the problem (very 
reproducable with software raid 5 -- never really tried much heavy disk 
use without raid.)

Edward King


