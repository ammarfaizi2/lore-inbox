Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317293AbSFRDYr>; Mon, 17 Jun 2002 23:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317300AbSFRDYq>; Mon, 17 Jun 2002 23:24:46 -0400
Received: from rrcs-sw-24-153-135-82.biz.rr.com ([24.153.135.82]:11921 "HELO
	UberGeek") by vger.kernel.org with SMTP id <S317293AbSFRDYo>;
	Mon, 17 Jun 2002 23:24:44 -0400
Subject: [Possibly OT] Re: /proc/scsi/map
From: Austin Gonyou <austin@digitalroadkill.net>
To: Doug Ledford <dledford@redhat.com>
Cc: Kurt Garloff <kurt@garloff.de>,
       Linux SCSI list <linux-scsi@vger.kernel.org>,
       Linux kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020617224046.A6590@redhat.com>
References: <20020615133606.GC11016@gum01m.etpnet.phys.tue.nl>
	 <20020617180818.C30391@redhat.com>
	 <20020617230648.GA3448@gum01m.etpnet.phys.tue.nl>
	  <20020617224046.A6590@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 17 Jun 2002 22:24:40 -0500
Message-Id: <1024370680.5490.8.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 2002-06-17 at 21:40, Doug Ledford wrote:
> On Tue, Jun 18, 2002 at 01:06:48AM +0200, Kurt Garloff wrote:
> > Hi Doug,
> > 
> .... 
> > In case you just add controllers, you just need to make sure you get them the
> > same numbers again. A solution for this exists already:
> > * For a kernel where SCSI low-level drivers are loaded as modules,
> >   you just need to keep the order constant
> > * For compiled in SCSI drivers, use scsihosts=
> 
....
> No, this is not true.  If you add a new controller (for some new disks in 
> a new external enclosure or whatever), and that controller uses the same 
> driver as other controller(s) in your system, then you have no guarantee 
> of order.  For example, adding a 4th aic7xxx controller to your system 
> might or might not place the new controller at the end of the list 
> depending on PCI scan order, etc.  There simply is *no* guarantee here of 
> any consistent naming, so don't bother trying to claim there is.
> 

Taking a bit of an example from Veritas, would it be, at all, feasible
if n+ blocks were used at the end of the disk or partition(beginning
maybe?), to write a specific identifier that is unique to a specific
controller, or to make note of the drive serial number and store that on
the disk somewhere in some agreed upon understood way. 

Much like the private region on a veritas disk or volume. With the extra
accounting, which should only be needed during boot, or during
disk/volume manipulation, one could conceivably always have a sane
device map, all the time. 

As to the rest of the comments lower down on the original mail, I'd say
that this is *a lot* of trouble, versus the opposite, but if implemented
properly would be highly useful. Using LVM and the like, which does
something like this, seems to be fine for most people(even when moving
disks around, etc), but this ability, without the overhead of LVM in the
mix would seem a good idea for some. 

Just my $.02
TIA
-- 
Austin Gonyou <austin@digitalroadkill.net>
