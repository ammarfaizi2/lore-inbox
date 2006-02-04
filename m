Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946108AbWBDACI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946108AbWBDACI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 19:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbWBDACH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 19:02:07 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:3600 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1751503AbWBDACH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 19:02:07 -0500
Date: Sat, 4 Feb 2006 01:02:05 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060204000205.GA4845@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Phillip Susi <psusi@cfl.rr.com>, linux-kernel@vger.kernel.org
References: <20060202062840.GI5501@mail> <43E1EA35.nail4R02QCGIW@burner> <20060202161853.GB8833@voodoo> <787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com> <Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr> <20060202210949.GD10352@voodoo> <20060203180421.GA57965@dspnet.fr.eu.org> <43E3B3F3.8060107@cfl.rr.com> <20060203204712.GA84752@dspnet.fr.eu.org> <43E3C5C5.5070301@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E3C5C5.5070301@cfl.rr.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 04:06:13PM -0500, Phillip Susi wrote:
> Olivier Galibert wrote:
> >No, it isn't.  OTOH, udev maintains it, so I guess that's good enough.
> >It makes udev the kernel interface though.  I hope they now care about
> >compatibility (/dev/.udev.pdb vs. /dev/.udev/db/* anyone?).
> >
> 
> Yes, it is, where do you think udev gets it's information from?

The device node name?  From the rules in /etc/udev/rules.d/*.  Udev is
the one which creates it in the first place, deriving it in a
user-defined way from the sysfs information.  It does _not_ give back
that information to the kernel.  Maybe it should.


> >Bullshit.  If <x> is the only interface available to a kernel service,
> >then <x> is part of the kernel whether you like it or not.  Case in
> >point, the ALSA library.
> 
> Bullshit yourself.  If cdrecord is the only application for burning cds, 
> that does not make it the kernel interface for cds, and certainly does 
> not make it part of the kernel.  The kernel interface is the point of 
> interaction between user and kernel code, which is sysfs.

The kernel does not provide a cd burning service, only a scsi packet
transport service called SG_IO.

The kernel *does* provide a device enumeration service, only it does
it at this point through udev for reasons that are 50% technical and
50% political.  If you want to be able to use a 2.6 kernel with
hotplug devices udev[1] is mandatory.  As such, from an engineering
point of view, udev is part of the kernel even if it isn't in the
source tarball on kernel.org.  And for now it is the lowest level
interface to device enumeration.

  OG.

[1] Or hotplug, maybe.

