Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310989AbSCROkF>; Mon, 18 Mar 2002 09:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310990AbSCROj4>; Mon, 18 Mar 2002 09:39:56 -0500
Received: from rover.mkp.net ([209.217.122.9]:15114 "EHLO rover")
	by vger.kernel.org with ESMTP id <S310989AbSCROjj>;
	Mon, 18 Mar 2002 09:39:39 -0500
To: Andrew Morton <akpm@zip.com.au>
Cc: Joel Becker <jlbec@evilplan.org>, Anton Altaparmakov <aia21@cam.ac.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: fadvise syscall?
From: "Martin K. Petersen" <mkp@mkp.net>
Organization: mkp.net
In-Reply-To: <3C945635.4050101@mandrakesoft.com> <3C945A5A.9673053F@zip.com.au>
	<3C945D7D.8040703@mandrakesoft.com>
	<5.1.0.14.2.20020317131910.0522b490@pop.cus.cam.ac.uk>
	<20020318080531.W4836@parcelfarce.linux.theplanet.co.uk>
	<3C95A1DB.CA13A822@zip.com.au>
Date: 18 Mar 2002 09:39:19 -0500
Message-ID: <yq1bsdmq6so.fsf@austin.mkp.net>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Civil Service)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew Morton <akpm@zip.com.au> writes:

Andrew> O_DIRECT is broken against RAID0 (at least) in 2.5 at present.
Andrew> The RAID driver gets sent BIOs which straddle two or more
Andrew> chunks and RAID spits out lots of unpleasant warnings.  Neil
Andrew> has been informed...

Yep.  I've been porting my original kiobuf based request splitter to
biobufs.  It's almost there, I've just been extremely busy with
something else for a while.

It's not only when you straddle chunks.  The current code does not
handle requests straddling RAID zones either.

-- 
Martin K. Petersen, Principal Linux Consultant, Linuxcare, Inc.
mkp@linuxcare.com, http://www.linuxcare.com/
SGI XFS for Linux Developer, http://oss.sgi.com/projects/xfs/

