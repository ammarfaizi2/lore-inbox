Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318447AbSGZTKo>; Fri, 26 Jul 2002 15:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318448AbSGZTKn>; Fri, 26 Jul 2002 15:10:43 -0400
Received: from tolkor.SGI.COM ([192.48.180.13]:60073 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S318447AbSGZTKm>;
	Fri, 26 Jul 2002 15:10:42 -0400
Date: Fri, 26 Jul 2002 14:13:34 -0500
From: Nathan Straz <nstraz@sgi.com>
To: John August <johna@babel.apana.org.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 Fuji 1300 usb-storage problem
Message-ID: <20020726191333.GB10675@sgi.com>
Mail-Followup-To: John August <johna@babel.apana.org.au>,
	linux-kernel@vger.kernel.org
References: <20020725102955.A700@babel.apana.org.au> <20020725162521.GA10675@sgi.com> <20020726165943.B552@babel.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020726165943.B552@babel.apana.org.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2002 at 04:59:43PM +1000, John August wrote:
> On Thu, Jul 25, 2002 at 11:25:21AM -0500, Nathan Straz wrote:
> > On Thu, Jul 25, 2002 at 10:29:55AM +1000, John August wrote:
> > > Note that it does not get as far as identifying the partition table,
> > > and the Model is indicated as FinePix 1400Zoom, when its in fact a 1300,
> > > and previously it was "USB-DRIVEUNIT" as the model.
> > 
> > Maybe the 1300 doesn't have as broken a USB implementation as the 1400
> > does.  In linux/drivers/usb/storage/unusual_devs.h there is an entry for
> > the 1400.
> 
> You have :
> 
> hub.c: USB new device connect on bus1/2, assigned device number 3
> scsi0 : SCSI emulation for USB Mass Storage devices
> Vendor: FUJIFILM  Model: USB-DRIVEUNIT     Rev: 1.00
> Type:   Direct-Access                      ANSI SCSI revision: 02
> Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
> 
> As the total output.
> 
> It appears the original "USB-DRIVEUNIT" code in 2.4.2-2 was OK, or there's
> some external problem in indentifying the sda device characteristics.

Hmm, are you sure you have SCSI disk support loaded (sd_mod)?

Since that didn't fix it, I'd suggest taking this to the linux-usb-devel
list.  You'll probably want to turn on the usb-storage debugging output
to get some more detail.  I think they would appreciate seeing all of
the kernel messages that result from plugging in the camera.  

Good luck, 
-- 
Nate Straz                                              nstraz@sgi.com
sgi, inc                                           http://www.sgi.com/
Linux Test Project                                  http://ltp.sf.net/
