Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265941AbRF2PRo>; Fri, 29 Jun 2001 11:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265905AbRF2PRe>; Fri, 29 Jun 2001 11:17:34 -0400
Received: from mercury.eng.emc.com ([168.159.40.77]:8966 "EHLO
	mercury.lss.emc.com") by vger.kernel.org with ESMTP
	id <S265891AbRF2PR1>; Fri, 29 Jun 2001 11:17:27 -0400
Message-ID: <2CE33F05597DD411AAE800D0B769587C01D59A40@sryoung.lss.emc.com>
From: "conway, heather" <conway_heather@emc.com>
To: "'Mike Black'" <mblack@csihq.com>,
        "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>
Subject: RE: Qlogic Fiber Channel
Date: Fri, 29 Jun 2001 11:17:17 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,
Looks like QLogic up-rev'd the driver versions on their website.  They have
the source code for both v4.25 and v4.27 posted now and rpm's for v4.25.
Hope that helps.
Heather  

> -----Original Message-----
> From: Mike Black [mailto:mblack@csihq.com]
> Sent: Friday, June 29, 2001 6:53 AM
> To: linux-kernel@vger.kernel.or
> Subject: Qlogic Fiber Channel
> 
> 
> I have been running successfully with qla2x00src-4.15Beta.tgz 
> for several
> months now over several kernel versions up to 2.4.5.
> When I tested 2.4.6-pre6 I decided to use the qlogicfc driver -- BAD
> MISTAKE!!!
> 
> #1 - My system had crashed (for a different reason) and when 
> the raid5 was
> resyncing and e2fsck happening at the same time the kernel locked with
> messages from qlogicfc.o:
> qlogicfc0: no handle slots, this should not happen.
> hostdata->queue  is 2a, inptr: 74
> I was able to repeat this several times so it's a consistent error.
> Waiting for the raid resync to finish did allow this complete 
> -- but now
> when I come in the next morning the console is locked up and 
> no network
> access either.  So I reset it.  Checked the logs and here it is again:
> Jun 29 03:39:21 yeti kernel: qlogicfc0 : no handle slots, 
> this should not
> happen.
> Jun 29 03:39:21 yeti kernel: hostdata->queued is 36, in_ptr: 13
> This was during a tape backup.
> 
> So I'm switching back to qla2x00src-4.15Beta.tgz -- which 
> does the resync
> and e2fsck just fine together BTW.
> Jun 29 06:22:47 yeti kernel: qla2x00: detect() found an HBA
> Jun 29 06:22:47 yeti kernel: qla2x00: VID=1077 DID=2100 
> SSVID=0 SSDID=0
> 
> Only problem is I don't see this package on qlogic's website 
> anymore and
> their "beta" directory is empty now.  I'm waiting to see what 
> their tech
> support says.
> 
> ________________________________________
> Michael D. Black   Principal Engineer
> mblack@csihq.com  321-676-2923,x203
> http://www.csihq.com  Computer Science Innovations
> http://www.csihq.com/~mike  My home page
> FAX 321-676-2355
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
