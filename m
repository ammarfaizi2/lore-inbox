Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbVC2P61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVC2P61 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 10:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVC2P61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 10:58:27 -0500
Received: from mail1.upco.es ([130.206.70.227]:2797 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S261176AbVC2P6T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 10:58:19 -0500
Date: Tue, 29 Mar 2005 17:58:16 +0200
From: Romano Giannetti <romanol@upco.es>
To: linux-kernel@vger.kernel.org
Subject: Re: ALPS touchpad woes with 2.6.12rc1 and rc1-mm3
Message-ID: <20050329155816.GA2526@pern.dea.icai.upco.es>
Mail-Followup-To: Romano Giannetti <romanol@upco.es>,
	linux-kernel@vger.kernel.org
References: <20050329113042.GA19324@pern.dea.icai.upco.es> <d120d500050329070423e3f01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <d120d500050329070423e3f01@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2005 at 10:04:06AM -0500, Dmitry Torokhov wrote:
> On Tue, 29 Mar 2005 13:30:42 +0200, Romano Giannetti <romanol@upco.es> wrote:
> > Hi all,
> > 
> >   In the kernels 2.6.12-rc1 and 2.6.12-rc1-mm3 my ALPS touchpad is not
> >   recognized by the Xorg driver. The strange thing is that in dmesg ALPS is
> >   detected, but then the Xorg driver tell strange things...
> > 
> 
> Could you please post your /proc/bus/input/devices from 2.6.12-rc1 to
> make sure that you are using correct event device. If you have noticed
> ALPS now registers 2 input devices. Btw, setting protocol to
> "auto-dev" in your X config helps dealing with event devices moving
> around.

This is /proc/bus/input/devices from  2.6.12-rc1-mm3. I changed the protocol
to auto-dev and commented out # Option "Device" "/dev/input/event1" and now
it works. What apparently happened is that from 2.6.11 to .12-rc1 the event
device changed from event1 to event2. 

Thanks and sorry for the post. Compiling in serial console now, to try to
see what happens with swsusp... 

Thanks again and have a nice day,
                                 Romano 

I: Bus=0011 Vendor=0001 Product=0001 Version=ab41
N: Name="AT Translated Set 2 keyboard"
P: Phys=isa0060/serio0/input0
H: Handlers=kbd mouse0 event0 
B: EV=120017 
B: KEY=40000 4 2000000 3802078 f840d001 f2ffffdf ffefffff ffffffff fffffffe 
B: REL=140 
B: MSC=10 
B: LED=7 

I: Bus=0011 Vendor=0002 Product=0008 Version=0000
N: Name="PS/2 Mouse"
P: Phys=isa0060/serio1/input1
H: Handlers=mouse1 event1 
B: EV=7 
B: KEY=70000 0 0 0 0 0 0 0 0 
B: REL=3 

I: Bus=0011 Vendor=0002 Product=0008 Version=7321
N: Name="AlpsPS/2 ALPS GlidePoint"
P: Phys=isa0060/serio1/input0
H: Handlers=mouse2 event2 
B: EV=f 
B: KEY=420 0 70000 0 0 0 0 0 0 0 0 
B: REL=3 
B: ABS=1000003 

I: Bus=0003 Vendor=05e3 Product=1205 Version=0110
N: Name="USB Mouse"
P: Phys=usb-0000:00:07.2-2/input0
H: Handlers=mouse3 event3 
B: EV=7 
B: KEY=70000 0 0 0 0 0 0 0 0 
B: REL=103 



-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
