Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262009AbUE3Kl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbUE3Kl7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 06:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbUE3Kl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 06:41:58 -0400
Received: from av9-2-sn2.hy.skanova.net ([81.228.8.180]:55698 "EHLO
	av9-2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S262009AbUE3Kle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 06:41:34 -0400
Subject: Re: Strange DMA-errors and system hang with Promise 20268
From: Henrik Persson <nix@syndicalist.net>
To: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>
Cc: linux-kernel@vger.kernel.org,
       Sebastian <sebastian@expires0604.datenknoten.de>,
       Bruce Allen <ballen@gravity.phys.uwm.edu>
In-Reply-To: <20040529144256.GA399@darkside.22.kls.lan>
References: <1078602426.16591.8.camel@vega> <c2dsha$psd$1@sea.gmane.org>
	 <20040529144256.GA399@darkside.22.kls.lan>
Content-Type: text/plain
Message-Id: <1085913685.3431.9.camel@vega>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 30 May 2004 12:41:26 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-05-29 at 16:42, Mario 'BitKoenig' Holbe wrote:
> Hi,
> 
> On Sun, Mar 07, 2004 at 02:05:46AM +0100, Mario 'BitKoenig' Holbe wrote:
> > Mar  4 01:01:06 darkside kernel: hde: dma_timer_expiry: dma status == 0x21
> 
> hmmm, it seems I solved the issue in my case.
> 
> I did just connect the two disks on the Promise to a second separate
> power supply and everything works rock-stable and survives all things
> that went wrong before (parallel fsck, parallel hdparm -t as well as
> 'normal operation' over days).
> Things remain stable even with the WDC disk connected back to the
> Promise, which was heavy unstable before.
> 
> Moreover, when I connect the disks back to the machines internal power
> supply, the problems arise again - immediately.
> 
> IMHO, this does also explain, why the problems happen while heavy I/O
> (parallel over all disks) and/or while S.M.A.R.T selftests are running
> (also: parallel over all disks).
> 
> Well, I thought, a 300W power supply would be enough for 1GHz P-III
> and 4 disks. And it definitely was enough for a long time.
> 
> Most likely, the power supply just aged and its capacity decreased.
> 
> Perhaps, the disks consume more power with newer kernels, but while
> crawling the lkm archives I found similar reports also for 2.4.19.
> 
> I have no idea, why always the disks connected to the Promise
> controller did fail. Perhaps, the Promise is more sensitive regarding
> signal quality on the IDE wire.
> 
> I have no idea, why my WDC disk failed when connected to the Promise,
> while others did work far more stable. Perhaps, the WDC disks signal
> quality under low-power is more bad than the one of other disks.
> 
> I have no idea, why the WDC disk did work well when it was connected
> to the onboard controller. Perhaps, the lower signal quality of the
> WDC (if so) and the sensitivity of the Promise (if so) added together
> was too much at all.
> 
> 
> Henrik, Sebastian: if you still have problems, this is probably
> something to test for you.

Well. I don't have those problems anymore but..I have a question..
Should the box freeze just because there is some powerfailures? :/

-- 
Henrik Persson <nix@syndicalist.net>

