Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964871AbWAWH0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbWAWH0A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 02:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbWAWH0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 02:26:00 -0500
Received: from audible.transient.net ([216.254.12.79]:59622 "HELO
	audible.transient.net") by vger.kernel.org with SMTP
	id S964871AbWAWHZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 02:25:59 -0500
Date: Sun, 22 Jan 2006 23:25:57 -0800
From: Jamie Heilman <jamie@audible.transient.net>
To: Ariel <askernel2615@dsgml.com>
Cc: Chase Venters <chase.venters@clientec.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: memory leak in scsi_cmd_cache 2.6.15
Message-ID: <20060123072556.GC15490@fifty-fifty.audible.transient.net>
Mail-Followup-To: Ariel <askernel2615@dsgml.com>,
	Chase Venters <chase.venters@clientec.com>,
	Arjan van de Ven <arjan@infradead.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <Pine.LNX.4.62.0601212105590.22868@pureeloreel.qftzy.pbz> <Pine.LNX.4.62.0601222045180.12815@pureeloreel.qftzy.pbz> <1137997104.2977.7.camel@laptopd505.fenrus.org> <200601230029.12674.chase.venters@clientec.com> <Pine.LNX.4.62.0601230136080.22979@pureeloreel.qftzy.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0601230136080.22979@pureeloreel.qftzy.pbz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ariel wrote:
> I'm on ICH5, but also Sil3112 and HighPoint 372N.
> 
> Jamie has ICH6 and Sil3112.
> 
> ata_piix seems like it's in common for all, but this is not a lot of 
> systems, so it could just be a coincidence and the problem caused by 
> something that's not chipset specific.

Hmm.  I just moved my sata_sil stuff out of the way and rebooted:

$ uptime; grep scsi_cmd_cache /proc/slabinfo
 23:22:16 up 4 min,  1 user,  load average: 0.00, 0.03, 0.00
scsi_cmd_cache      1200   1200    384   10    1 : tunables   54   27   8 : slabdata    120    120      0

My other workstation also runs 2.6.15.1 but uses sata_nv and doesn't
exhibit the problem.

-- 
Jamie Heilman                     http://audible.transient.net/~jamie/
