Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261854AbVADUfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbVADUfa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 15:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbVADUf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 15:35:26 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:62985 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261854AbVADUet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 15:34:49 -0500
Date: Tue, 4 Jan 2005 21:34:44 +0100
From: Adrian Bunk <bunk@stusta.de>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Diego Calleja <diegocg@teleline.es>, Willy Tarreau <willy@w.ods.org>,
       davidsen@tmr.com, aebr@win.tue.nl, solt2@dns.toxicfilms.tv,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050104203444.GL3097@stusta.de>
References: <20050103004551.GK4183@stusta.de> <20050103011935.GQ29332@holomorphy.com> <20050103053304.GA7048@alpha.home.local> <20050103142412.490239b8.diegocg@teleline.es> <20050103134727.GA2980@stusta.de> <20050104125738.GC2708@holomorphy.com> <20050104150810.GD3097@stusta.de> <20050104153445.GH2708@holomorphy.com> <20050104165301.GF3097@stusta.de> <20050104195725.GQ2708@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050104195725.GQ2708@holomorphy.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 11:57:25AM -0800, William Lee Irwin III wrote:
>...
> On Tue, Jan 04, 2005 at 05:53:01PM +0100, Adrian Bunk wrote:
> > And then there are issues that are not bugs in the code, but user errors 
> > that have to be avoided. An example is CONFIG_BLK_DEV_UB in 2.6.9, which 
> > even the Debian kernel maintainers got wrong in the first kernel 
> > packages they did put into Debian unstable.
> 
> PEBKAC is entirely out of the scope of any program not making direct
> efforts at HCI. CONFIG_BLK_DEV_UB was documented for what it was, and
> users configuring kernels are not assumed to be naive.


<--  snip  -->

config BLK_DEV_UB
        tristate "Low Performance USB Block driver"
        depends on USB
        help
          This driver supports certain USB attached storage devices
          such as flash keys.

          If unsure, say N.

<--  snip  -->


Call me naive, but at least for me it wouldn't have been obvious that 
this option cripples the usb-storage driver.


The warning that this option cripples the usb-storage driver was added 
after people who accidentially enabled this option ("it can't harm") 
in 2.6.9 swamped the USB maintainers with bug reports about problems 
with their storage devices.


> -- wli

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

