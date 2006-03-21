Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030314AbWCUCZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030314AbWCUCZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 21:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030328AbWCUCZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 21:25:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52667 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030306AbWCUCZ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 21:25:27 -0500
Date: Mon, 20 Mar 2006 21:25:15 -0500
From: Dave Jones <davej@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: sander@humilis.net, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, lkml@rtr.ca,
       pjones@redhat.com
Subject: Re: Some sata_mv error messages
Message-ID: <20060321022515.GI29589@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jeff Garzik <jgarzik@pobox.com>, sander@humilis.net,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, lkml@rtr.ca, pjones@redhat.com
References: <20060318044056.350a2931.akpm@osdl.org> <20060320133318.GB32762@favonius> <441F508E.1030008@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <441F508E.1030008@pobox.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 08:02:06PM -0500, Jeff Garzik wrote:
 > Sander wrote:
 > >Hi all,
 > >
 > >While sata_mv in 2.6.16-rc6-mm2 seems stable (yah!) compared to
 > >2.6.16-rc6 (no crashes, no data corruption), I still get these messages:
 > >
 > >[ 3962.139906] ata5: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 
 > >0xb/47/00
 > >[ 3962.139959] ata5: status=0xd0 { Busy }
 > >
 > >[ 6105.948045] ata6: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 
 > >0xb/47/00
 > >[ 6105.948097] ata6: status=0xd0 { Busy }
 > >
 > >[ 7981.164936] ata5: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 
 > >0xb/47/00
 > >[ 7981.164991] ata5: status=0xd0 { Busy }
 > >
 > >[ 8273.951019] ata7: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 
 > >0xb/47/00
 > >[ 8273.951072] ata7: status=0xd0 { Busy }
 > >
 > >[ 9903.032350] ata8: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 
 > >0xb/47/00
 > >[ 9903.032402] ata8: status=0xd0 { Busy }
 > >
 > >
 > >I'm not entirely sure this is only happens on sata_mv (Marvell
 > >MV88SX6081) as out of eight disks only one is connected to the onboard
 > >sata_nv (nVidia) and the error doesn't happen very often. But I'll keep
 > >an eye on it.
 > >
 > >Are these messages somehow dangerous or otherwise indicating a
 > >potentional serious problem? A google search came up with a few links,
 > >but none of them helped me understand the messages.
 > 
 > Without answering your specific question, just remember that sata_mv is 
 > considerly "highly experimental" right now, and still needs some 
 > workarounds for hardware errata.
 > 
 > For now, the goal is a system that doesn't crash and doesn't corrupt 
 > data.  If its occasionally slow or spits out a few errors, but otherwise 
 > still works, that's pretty darned good :)

Reminds me, this message (though different error codes) gets spewed to the
console a lot when haldaemon polls SATA CD drives.
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=183348

This wasn't occasional, this was every few seconds, making the box
pretty much unusable.

		Dave

-- 
http://www.codemonkey.org.uk
