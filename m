Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbTKTNqX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 08:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbTKTNqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 08:46:23 -0500
Received: from muncii-fe0.b.astralnet.ro ([194.102.255.69]:37064 "EHLO
	linux.kappa.ro") by vger.kernel.org with ESMTP id S261840AbTKTNqV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 08:46:21 -0500
Date: Thu, 20 Nov 2003 15:46:20 +0200
From: Teodor Iacob <Teodor.Iacob@astral.ro>
To: "Feldman, Scott" <scott.feldman@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Intel E1000 and IDE problems
Message-ID: <20031120134620.GB6433@speedy.b.astralnet.ro>
References: <C6F5CF431189FA4CBAEC9E7DD5441E0102CBDCE4@orsmsx402.jf.intel.com> <20031120112217.GA22057@speedy.b.astralnet.ro> <20031120124535.GA32427@speedy.b.astralnet.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20031120124535.GA32427@speedy.b.astralnet.ro>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Last thing I did.. I changed the motherboard from Soltek 75DRV5 with KT333
to a Shuttle with KT400 .. no problems anymore. Sorry for the spam
and trouble :)

On Thu, Nov 20, 2003 at 02:45:35PM +0200, Teodor Iacob wrote:
> One more thing to add:
> 
> After a few of those kind of freezes the BIOS won't even recognize the
> Harddisk anymore, I had to turn on the machine without the harddisk in it
> then I forced the bios to update ESCD and the put back the harddrive in it
> and worked. Somehow those cards affect the system anyway. ( even only in
> CMOS setup )
> 
> On Thu, Nov 20, 2003 at 01:22:17PM +0200, Teodor Iacob wrote:
> > I found something really interesting. I am now able to reproduce problems 
> > exactly at the same point:
> > 
> > If I boot the machine without ethernet cables connected before loading
> > the kernel the machine seems to work fine for a while. If I put for
> > example a crossover cable between the cards I cannot even boot the system!
> > right after the kernel initialization after it starts the init I get
> > IDE errors and then freezes because it cannot run the commands in
> > rc.sysinit.
> > 
> > I have to mention I also tried the built-in driver of intel e1000.
> > The 5.2.20 of course it was loaded as a module at network scripts
> > initialization.
> > 
> > So the problems trims down to how can those NICs can affect the IDE
> > only when they have cables connected ( even though without the driver
> > initialization they don't have the led link on ) even without traffic
> > going through them.
> > 
> > On Wed, Nov 19, 2003 at 07:02:27PM -0800, Feldman, Scott wrote:
> > > > I recently put up 2 intel network adapters:
> > > > 00:09.0 Ethernet controller: Intel Corp. 82545EM Gigabit 
> > > > Ethernet Controller (Copper) (rev 01)
> > > > 00:0b.0 Ethernet controller: Intel Corp. 82545EM Gigabit 
> > > > Ethernet Controller (Copper) (rev 01)
> > > > 
> > > > ( I replaced some Intel PRO1000 Desktop which I had before ) and now
> > > > I get serious problems with the hda disk:
> > > 
> > > Did you put the 82545 nics in the same slots where you had the desktop
> > > nics?
> > > 
> > > Are the 82545 nics on the same bus segment as the disk controller?  Are
> > > there any shared interrupts?  See lcpci -vvv.
> > > 
> > > -scott
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 

-- 
      Teodor Iacob,
Manager Infrastructura Nationala
Astral Telecom Internet
