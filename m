Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262742AbTELV2q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 17:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbTELV2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 17:28:46 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:50449
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S262742AbTELV2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 17:28:45 -0400
Date: Mon, 12 May 2003 14:41:23 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Jens Axboe <axboe@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 ide 48-bit usage
Message-ID: <20030512214123.GA3849@matchmail.com>
Mail-Followup-To: Jens Axboe <axboe@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030507175033.GR823@suse.de> <Pine.SOL.4.30.0305072119530.27561-100000@mion.elka.pw.edu.pl> <20030507201949.GW823@suse.de> <20030508075609.GJ823@suse.de> <1052391717.10037.5.camel@dhcp22.swansea.linux.org.uk> <20030508120145.GR823@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030508120145.GR823@suse.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08, 2003 at 02:01:45PM +0200, Jens Axboe wrote:
> On Thu, May 08 2003, Alan Cox wrote:
> > On Iau, 2003-05-08 at 08:56, Jens Axboe wrote:
> > > That part is added, I still kept it at 65535 though akin to how we don't
> > > use that last sector in 28-bit commands either. For 48-bit commands this
> > > is totally irelevant, 32MiB or 32MiB-512b doesn't matter either way.
> > 
> > Actually I changed the LBA28 code to use the last sector a while ago. It
> > has (unsuprisingly) caused zero problems because other OS's also
> > generate such requests.
> 
> That's great, if you remember that was my requirement for usage of the
> last sector, that the Other OS used it. If it does, it can't be buggy.

Yes, there is documentation in ntfs-tools about the kernel not being able to
address the last sector like the Other OS does, and recommending to run
chkdsk immediately after creating a new ntfs volume under Linux...
