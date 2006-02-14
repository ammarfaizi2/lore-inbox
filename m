Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030351AbWBNEur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030351AbWBNEur (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 23:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030352AbWBNEur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 23:50:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58045 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030350AbWBNEup (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 23:50:45 -0500
Date: Mon, 13 Feb 2006 23:48:42 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Michal Jaegermann <michal@harddata.com>, arjan@infradead.org,
       len.brown@intel.com, davem@davemloft.net, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, axboe@suse.de,
       James.Bottomley@steeleye.com, greg@kroah.com,
       linux-acpi@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       luming.yu@intel.com, lk@bencastricum.nl, sanjoy@mrao.cam.ac.uk,
       helgehaf@aitel.hist.no, fluido@fluido.as, gbruchhaeuser@gmx.de,
       Nicolas.Mailhot@LaPoste.net, perex@suse.cz, tiwai@suse.de,
       patrizio.bassi@gmail.com, bni.swe@gmail.com, arvidjaar@mail.ru,
       p_christ@hol.gr, ghrt@dial.kappa.ro, jinhong.hu@gmail.com,
       andrew.vasquez@qlogic.com, linux-scsi@vger.kernel.org, bcrl@kvack.org
Subject: Re: Linux 2.6.16-rc3
Message-ID: <20060214044842.GA3184@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>,
	Michal Jaegermann <michal@harddata.com>, arjan@infradead.org,
	len.brown@intel.com, davem@davemloft.net, torvalds@osdl.org,
	linux-kernel@vger.kernel.org, axboe@suse.de,
	James.Bottomley@steeleye.com, greg@kroah.com,
	linux-acpi@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
	luming.yu@intel.com, lk@bencastricum.nl, sanjoy@mrao.cam.ac.uk,
	helgehaf@aitel.hist.no, fluido@fluido.as, gbruchhaeuser@gmx.de,
	Nicolas.Mailhot@LaPoste.net, perex@suse.cz, tiwai@suse.de,
	patrizio.bassi@gmail.com, bni.swe@gmail.com, arvidjaar@mail.ru,
	p_christ@hol.gr, ghrt@dial.kappa.ro, jinhong.hu@gmail.com,
	andrew.vasquez@qlogic.com, linux-scsi@vger.kernel.org,
	bcrl@kvack.org
References: <F7DC2337C7631D4386A2DF6E8FB22B30060BD1D9@hdsmsx401.amr.corp.intel.com> <20060213001240.05e57d42.akpm@osdl.org> <1139821068.2997.22.camel@laptopd505.fenrus.org> <20060214030821.GA23031@mail.harddata.com> <20060213192838.64013c6c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060213192838.64013c6c.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2006 at 07:28:38PM -0800, Andrew Morton wrote:
 > Michal Jaegermann <michal@harddata.com> wrote:
 > >
 > > On Mon, Feb 13, 2006 at 09:57:48AM +0100, Arjan van de Ven wrote:
 > > > On Mon, 2006-02-13 at 00:12 -0800, Andrew Morton wrote:
 > > > > 
 > > > > I think we can assume that it will be seen there.  2.6.16 is going into
 > > > > distros and will have more exposure than 2.6.15, 
 > > > 
 > > > 2.6.15 went into distros as well, such as Fedora Core 4 ;)
 > > 
 > > And promptly broke laptop suspension.  See, for example:
 > > https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=180998
 > > 
 > 
 > That's suspend-to-disk, yes?
 > 
 > Dave, would you have the 2.6.15-1.1830_FC4 -> 2.6.15-1.1831_FC4 details
 > handy?  There surely can't be much difference?

Tiny changes.
- The icmp remote DoS fix.
- Dropped a patch that broke booting with 'quiet' bootparam
- the 'dm_crypt: zero key before freeing it' change

 > There seem to be several ACPI problems there.  Do we have a reliable means
 > of feeding such reports up into the (for example) acpi developers?
 > 
 > <I have this vaguely unsettled feeling that distros must get more bug
 > reports than the usptream developers, yet we hear so little about it>

I'd love more hours in the day to push more of them upstream, as
I bet would other vendors kernel maintainers.

Should anyone want to drink from the firehose that is 'redhat kernel bugzilla',
let me know, and I'll see if I can't get a fedora-kernel-bugs mailing
list or the like set up.

Some subsystem maintainers (ACPI for example) really help out here,
and add acpi-bugzilla@list.sourceforge.net to all the Fedora ACPI bugs.
(I believe that list actually gets bug reports from other distro bugzillas too)

(There's also a few 'meta-bugs' -- enter FCMETA_ACPI as a bug id
and you get a link to a dependancy tree showing all the ACPI bugs
reported. There's a bunch of those for various subsystems which
makes it a little easier to track, though again, it's time-consuming
just sorting through stuff).  Off the top of my head, theres one
for USB, SCSI, ACPI, ALSA, SATA (All with FCMETA_ prefix)
Some of them are a bit sparse due to lack of time & effort so far.
		
		Dave

