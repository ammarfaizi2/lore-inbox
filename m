Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbUCCMZS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 07:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262452AbUCCMZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 07:25:18 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:64394 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262454AbUCCMZK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 07:25:10 -0500
Date: Wed, 3 Mar 2004 13:25:06 +0100
From: Jens Axboe <axboe@suse.de>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 ide-cd DMA ripping
Message-ID: <20040303122506.GS9196@suse.de>
References: <20040303113756.GQ9196@suse.de> <200403031226.22015.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403031226.22015.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03 2004, Alistair John Strachan wrote:
> On Wednesday 03 March 2004 11:37, you wrote:
> > Hi,
> >
> > 2.6 still uses PIO for CDROMREADAUDIO cdda ripping, which is less than
> > optimal of course... This patch uses the block layer infrastructure to
> > enable zero copy DMA ripping through CDROMREADAUDIO.
> >
> > I'd appreciate people giving this a test spin. Patch is against
> > 2.6.4-rc1 (well current BK, actually).
> >
> [snip] 
> 
> Is this a general optimisation, i.e. will the rip methods used by
> cdda2wav and cdparanoia, etc. be optimised, or do you need some
> specific userspace tools to utilise it?

The patch only affects CDROMREADAUDIO ioctl. cdda2wav (with recent
libscg) will use SG_IO, which works equally well already. cdparanoia
uses CDROMREADAUDIO as well iirc, if it can use /dev/sg* sg v2
interface. I'm not completely sure, if you send me an strace of the
process in question I can tell you for sure :)

-- 
Jens Axboe

