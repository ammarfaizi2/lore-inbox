Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261409AbSKKV3t>; Mon, 11 Nov 2002 16:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261411AbSKKV3t>; Mon, 11 Nov 2002 16:29:49 -0500
Received: from amsfep11-int.chello.nl ([213.46.243.20]:10548 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id <S261409AbSKKV3s>; Mon, 11 Nov 2002 16:29:48 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jos Hulzink <josh@stack.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: Sound: DMA (output) timed out - IRQ/DRQ config error?
Date: Mon, 11 Nov 2002 22:36:26 +0100
User-Agent: KMail/1.4.3
References: <20021111214248.A24021@beton.cybernet.cz>
In-Reply-To: <20021111214248.A24021@beton.cybernet.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211112236.26285.josh@stack.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 November 2002 21:42, Karel Kulhavy wrote:
> I get Sound: DMA (output) timed out - IRQ/DRQ config error?
> On a PPro 200MHz (DELL OptiPlex Pro) with builting Soudblaster (OSS)
> and massive access to SCSI disk AHA 1524 (tar xzvf of a big archive)
>
>   7:     686036          XT-PIC  soundblaster
>  10:     614871          XT-PIC  aha152x
>
> I would be worth the effort to block interrupts within the drivers
> only on an absolutely necessary way. Or is it already happening?

Sounds to me you are causing the ISA bus to smoke... An ISA bus can only 
handle at most 16 MB / s but this is a pure theoretical limit, 8 MB / s is a 
more sane value. And when the SCSI controller fills the buffer of the disk it 
is damn good possible your ISA bus is flooded with data for about 1/8 sec.. 

this shouldn't happen, but iMHO you should use a PCI SCSI controller if you do 
"massive access" to disks...

Jos


