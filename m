Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310458AbSCLG6u>; Tue, 12 Mar 2002 01:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310451AbSCLG6l>; Tue, 12 Mar 2002 01:58:41 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:62726 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S310438AbSCLG6a>;
	Tue, 12 Mar 2002 01:58:30 -0500
Date: Tue, 12 Mar 2002 07:58:06 +0100
From: Jens Axboe <axboe@suse.de>
To: Kurt Garloff <garloff@suse.de>, Douglas Gilbert <dougg@torque.net>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Jeremy Higdon <jeremy@classic.engr.sgi.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        James Bottomley <James.Bottomley@SteelEye.com>,
        Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3)
Message-ID: <20020312065806.GX704@suse.de>
In-Reply-To: <200202281536.g1SFaqF02079@localhost.localdomain> <E16heCm-0000Q5-00@starship.berlin> <10203032021.ZM443706@classic.engr.sgi.com> <E16hl4R-0000Zx-00@starship.berlin> <phillips@bonn-fries.net> <10203032209.ZM424559@classic.engr.sgi.com> <20020304165216.A1444@redhat.com> <3C8AEDFC.502CAD04@torque.net> <20020311121300.G2346@nbkurt.etpnet.phys.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020311121300.G2346@nbkurt.etpnet.phys.tue.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11 2002, Kurt Garloff wrote:
> disks (DASDs), Write-Once and Optical Memory devices. (Funny enough, the
> SCSI spec also lists SYNCHRONIZE_CACHE for CD-Rom devices

Hey, I use SYNCHRONIZE_CACHE in the packet writing stuff for CD-ROM's
all the time :-). Not all are read-only. In fact, Peter Osterlund
discovered that if you have pending writes on the CD-ROM it's a really
good idea to sync the cache prior to starting reads or they have a nasty
tendency to time out.

-- 
Jens Axboe

