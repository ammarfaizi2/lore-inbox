Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129381AbRBUXpu>; Wed, 21 Feb 2001 18:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129669AbRBUXpk>; Wed, 21 Feb 2001 18:45:40 -0500
Received: from [209.53.18.145] ([209.53.18.145]:7810 "EHLO continuum.cm.nu")
	by vger.kernel.org with ESMTP id <S129381AbRBUXpc>;
	Wed, 21 Feb 2001 18:45:32 -0500
Date: Wed, 21 Feb 2001 15:45:21 -0800
From: Shane Wegner <shane@cm.nu>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] VIA 4.2x driver for 2.2 kernels
Message-ID: <20010221154521.A2936@cm.nu>
In-Reply-To: <20010220134028.A5762@suse.cz> <20010220155927.A1543@cm.nu> <20010221080919.A469@suse.cz> <20010220231502.A4618@cm.nu> <20010221082348.A908@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010221082348.A908@suse.cz>; from vojtech@suse.cz on Wed, Feb 21, 2001 at 08:23:48AM +0100
Organization: Continuum Systems, Vancouver, Canada
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2001 at 08:23:48AM +0100, Vojtech Pavlik wrote:
> On Tue, Feb 20, 2001 at 11:15:02PM -0800, Shane Wegner wrote:
> > On Wed, Feb 21, 2001 at 08:09:19AM +0100, Vojtech Pavlik wrote:
> > > 
> > > > > You wanted my VIA driver for 2.2. Here is a patch that brings the very
> > > > > latest 4.2 driver to the 2.2 kernel. The patch is against the
> > > > > 2.2.19-pre13 kernel plus yours 1221 ide patch.
> > > > 
> > > > This drivers breaks with my HP 8110 CD-R drive.  It's
> > > > sitting on primary slave of a Via 686B controler.  When I
> > > > try to do a hdparm -d1 -u1 -k1 /dev/hdb, the kernel locks
> > > > up hard.  Not even an oops.  Reverting to the old driver
> > > > works fine.
> > > 
> > > Don't do that. Use the kernel option to enable DMA instead.

Hi,

I have investigated this problem further.  The hdparm
triggers the error but is not the cause.  hdparm accesses
/dev/hdb which is my cd-r drive.  This triggers the loading
of the cdrom and ide-cd modules.  Manually loading cdrom
succeeds, after which, manually loading ide-cd crashes the
system.  No need to even open() the device.  This works
fine with the VIA driver from 2.2.19pre14+ide-2.2.18-1221.

Regards,
Shane

-- 
Shane Wegner: shane@cm.nu
              http://www.cm.nu/~shane/
PGP:          1024D/FFE3035D
              A0ED DAC4 77EC D674 5487
              5B5C 4F89 9A4E FFE3 035D
