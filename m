Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263730AbTIIHGb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 03:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263965AbTIIHGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 03:06:31 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:29624 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S263730AbTIIHFS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 03:05:18 -0400
Date: Tue, 9 Sep 2003 10:05:07 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Stephan von Krawczynski <skraw@ithnet.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.22pre8 hangs too (Re: 2.4.21-jam1 solid hangs)
Message-ID: <20030909070506.GL150921@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Stephan von Krawczynski <skraw@ithnet.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.55L.0308291325480.29088@freak.distro.conectiva> <20030829195737.GI150921@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030829195737.GI150921@niksula.cs.hut.fi>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 29, 2003 at 10:57:37PM +0300, you [Ville Herva] wrote:
> On Fri, Aug 29, 2003 at 01:35:25PM -0300, you [Marcelo Tosatti] wrote:
> > 
> > So NMI and sysrq doesnt help. I suggest you a few things:
> > 
> > Try to make the bug easy to reproduce. Force the Oracle dumps again and
> > again to crash the box. 
> 
> I happened to work towards that direction this morning (before I read your
> mail). Taking the stance that this very probably had something to do with io
> stress, I played around with several io loads. Eventually I found out that
> fsx on scsi disk reliably caused the box to either lock up or the aic7xxx
> driver to barf. What's more, it took under 15 minutes to trigger.
> 
> So I copied the rootfs and everything else from the scsi disk to the ide
> disk (just barely had enough space), and took all the scsi disk partitions
> away from fstab. After reboot, I have been unable to lock it up with fsx
> (scsi disk is not accessed at all), but it will take several weeks before
> I'm confident that the lock up is cured.

And indeed it did lock even though the scsi disk is not used at all. It just
took weeks. 

At the time no heavy IO was going on afaict (but there might have been some
io.)

I'm completely out of ideas here. What the heck is the culprit...? Perhaps a
faulty motherboard?

> The hw is:
>  Intel 815EEA2LU (i815 Chipset)
>  Celeron 1.3GHz (Tualatin)
>  Adaptec AHA-2940 / AIC-7871 (NOT USED)
>    - Disk          SEAGATE  Model: ST19171W Rev: 0024 (NOT USED)
>    - Tape Drive    HP       Model: C1537A Rev: L708
>  30GB IDE disk  (All fs's here at the moment)


 
-- v --

v@iki.fi
