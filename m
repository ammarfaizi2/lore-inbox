Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262908AbSJWH5w>; Wed, 23 Oct 2002 03:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262912AbSJWH5w>; Wed, 23 Oct 2002 03:57:52 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:676 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262908AbSJWH5v>; Wed, 23 Oct 2002 03:57:51 -0400
Date: Wed, 23 Oct 2002 10:03:20 +0200
To: venom@sns.it, linux-kernel@vger.kernel.org
Subject: Re: 2.5.44: /proc/stat not reporting all disks statistics
Message-ID: <20021023080318.GA655@neljae>
Mail-Followup-To: venom@sns.it, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.43.0210230137380.25356-100000@cibs9.sns.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.43.0210230137380.25356-100000@cibs9.sns.it>
User-Agent: Mutt/1.4i
From: Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 01:42:18AM +0200, venom@sns.it wrote:
> I have on this system two disks, primary master and secondary master,
> hda and hdc.
> 
> In /proc/stat
> i see just:
> 
> disk_io: (3,0):(24382,16849,158610,7533,382512)
> 
> so, I see 22,0 disk (hdc) is somehow missing.

By default, the kernel only collects statistics on majors 1 to 16.  If
you want the disks on your second IDE channel to show up, go to
include/linux/kernel_stat.h and raise the limit DK_MAX_MAJOR to 22 or
higher.  (Assuming 2.5 stats still work the same as in 2.4, that is.)

Daniel.

