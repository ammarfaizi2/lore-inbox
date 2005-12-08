Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbVLHV3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbVLHV3W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 16:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932602AbVLHV3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 16:29:22 -0500
Received: from fmr17.intel.com ([134.134.136.16]:6631 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932398AbVLHV3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 16:29:20 -0500
Date: Thu, 8 Dec 2005 13:31:44 -0800
From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: erik@slagter.name, hch@infradead.org, mjg59@srcf.ucam.org,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: RFC: ACPI/scsi/libata integration and hotswap
Message-Id: <20051208133144.0f39cb37.randy_d_dunlap@linux.intel.com>
In-Reply-To: <43989B00.5040503@pobox.com>
References: <20051208030242.GA19923@srcf.ucam.org>
	<20051208091542.GA9538@infradead.org>
	<20051208132657.GA21529@srcf.ucam.org>
	<20051208133308.GA13267@infradead.org>
	<20051208133945.GA21633@srcf.ucam.org>
	<20051208134438.GA13507@infradead.org>
	<1134062330.1732.9.camel@localhost.localdomain>
	<43989B00.5040503@pobox.com>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
X-Face: "}I"O`t9.W]b]8SycP0Jap#<FU!b:16h{lR\#aFEpEf\3c]wtAL|,'>)%JR<P#Yg.88}`$#
 A#bhRMP(=%<w07"0#EoCxXWD%UDdeU]>,H)Eg(FP)?S1qh0ZJRu|mz*%SKpL7rcKI3(OwmK2@uo\b2
 GB:7w&?a,*<8v[ldN`5)MXFcm'cjwRs5)ui)j
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Dec 2005 15:43:44 -0500
Jeff Garzik <jgarzik@pobox.com> wrote:

> Erik Slagter wrote:
> > 'guess You're not interested in having suspend/resume actually work on
> > laptops (or other PC's). That's your prerogative but imho it's a bit
> > narrow-minded to withhold this functionality from other people who
> > actually would like to have this working, just because you happen to not
> > like ACPI.
> 
> It works just fine on laptops, with Jens' suspend/resume patch.

I have seen a few other people report that SATA suspend/resume
works when using Jens's patch.  However, this is done without
the benefit of what the additional ACPI methods provide thru
_GTF and writing those taskfiles, such as:
- enabling write cache
- enabling device power management
- freezing the security password

so even when it "works," those people may be missing some
performance benefits or power savings or security.

In any case, I'm glad to see some discussion of this.

---
~Randy
