Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261795AbVA3VsC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbVA3VsC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 16:48:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbVA3VsC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 16:48:02 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:39941 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261795AbVA3Vrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 16:47:39 -0500
Date: Sun, 30 Jan 2005 22:56:21 +0100
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Dave Airlie <airlied@gmail.com>,
       Andreas Hartmann <andihartmann@01019freenet.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.10 dies when X uses PCI radeon 9200 SE, further binary search result
Message-ID: <20050130215621.GA25824@hh.idb.hist.no>
References: <fa.ks44mbo.ljgao4@ifi.uio.no> <fa.hinb9iv.s38127@ifi.uio.no> <41F21FA4.1040304@pD9F8757A.dip0.t-ipconnect.de> <21d7e99705012205012c95665@mail.gmail.com> <41F76B4D.8090905@hist.no> <20050130111634.GA9269@hh.idb.hist.no> <21d7e9970501300322ffdabe0@mail.gmail.com> <9e473391050130070520631901@mail.gmail.com> <20050130163241.GA18036@hh.idb.hist.no> <9e473391050130090532067a5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e473391050130090532067a5f@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2005 at 12:05:27PM -0500, Jon Smirl wrote:
> On Sun, 30 Jan 2005 17:32:41 +0100, Helge Hafting
> <helgehaf@aitel.hist.no> wrote:
> > Yes, it is a PCI radeon.  And the machine has an AGP slot
> > too, which is used by a matrox G550.  This AGP card was not
> > used in the test, (other than being the VGA console).
> > Note that there is no crash if I don't compile
> > AGP support, so the crash is related to AGP somehow even though
> > AGP is not supposed to be used in this case.
> 
> Can you set the PCI card to be primary in your BIOS or remove the AGP
> card, and then see if it works? It could be that X's video reset code
> for secondary PCI cards is broken.
> 
I set the PCI card to primary, and kept the AGP card. Then I booted up
2.6.9-rc3 which normally crashes hard when X starts.  

But now X came up just fine on the radeon!  The log indicates
no problems with drm either, I did not get a "pci oom".
I didn't actually test with glxgears, but drm came up according
to the logs.
I did not change the X setup, so the pci card was initialized by
int10 although that wasn't necessary this time.


I have not yet tested wether the AGP card works in this configuration, my
user was impatient so I had to restore a known working configuration.

Helge Hafting

