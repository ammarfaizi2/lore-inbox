Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261722AbVA3QYB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbVA3QYB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 11:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVA3QYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 11:24:01 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:7172 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261722AbVA3QX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 11:23:59 -0500
Date: Sun, 30 Jan 2005 17:32:41 +0100
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Dave Airlie <airlied@gmail.com>, Helge Hafting <helgehaf@aitel.hist.no>,
       Andreas Hartmann <andihartmann@01019freenet.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.10 dies when X uses PCI radeon 9200 SE, further binary search result
Message-ID: <20050130163241.GA18036@hh.idb.hist.no>
References: <fa.ks44mbo.ljgao4@ifi.uio.no> <fa.hinb9iv.s38127@ifi.uio.no> <41F21FA4.1040304@pD9F8757A.dip0.t-ipconnect.de> <21d7e99705012205012c95665@mail.gmail.com> <41F76B4D.8090905@hist.no> <20050130111634.GA9269@hh.idb.hist.no> <21d7e9970501300322ffdabe0@mail.gmail.com> <9e473391050130070520631901@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e473391050130070520631901@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2005 at 10:05:16AM -0500, Jon Smirl wrote:
> I just checked out on current Linus BK with my AGP Radeon 9000 which
> is pretty close to a 9200. Everything is working fine.
> 
> I notice from his logs that he is running a PCI radeon, not an AGP
> one. Didn't someone make some changes to the PCI radeon memory
> management code recently? I run a PCI R128 and that is still working.
> DRM debug output might give more clues.
> 
Yes, it is a PCI radeon.  And the machine has an AGP slot
too, which is used by a matrox G550.  This AGP card was not
used in the test, (other than being the VGA console).
Note that there is no crash if I don't compile 
AGP support, so the crash is related to AGP somehow even though
AGP is not supposed to be used in this case.

As I start X (on the radeon) I notice that the VGA console 
I'm using (on the G550 AGP) goes black.  I see no need for that either,
the radeon display is a _different_ device so why black out 
the vgacon?  Could the problem lurk there somehow?

Helge Hafting

