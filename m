Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315265AbSFTQul>; Thu, 20 Jun 2002 12:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315277AbSFTQuk>; Thu, 20 Jun 2002 12:50:40 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:45784 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S315265AbSFTQui>; Thu, 20 Jun 2002 12:50:38 -0400
Date: Thu, 20 Jun 2002 18:50:12 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jens Axboe <axboe@suse.de>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
       Paul Bristow <paul@paulbristow.net>,
       Gadi Oxman <gadio@netvision.net.il>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.22] simple ide-tape.c and ide-floppy.c cleanup
In-Reply-To: <20020620164417.GA3893@suse.de>
Message-ID: <Pine.SOL.4.30.0206201847260.23175-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Jun 2002, Jens Axboe wrote:

> On Thu, Jun 20 2002, Bartlomiej Zolnierkiewicz wrote:
> >
> > On Thu, 20 Jun 2002, Martin Dalecki wrote:
> >
> > > U?ytkownik Jens Axboe napisa?:
> > > > On Thu, Jun 20 2002, Martin Dalecki wrote:
> > > >
> > > >>U?ytkownik Jens Axboe napisa?:
> > > >>
> > > >>>On Wed, Jun 19 2002, Bartlomiej Zolnierkiewicz wrote:
> > > >>>
> > > >>>Looks pretty good in general, just one minor detail:
> > > >>>
> > > >>>
> > > >>>
> > > >>>>+
> > > >>>>+/*
> > > >>>>+ *	ATAPI packet commands.
> > > >>>>+ */
> > > >>>>+#define ATAPI_FORMAT_UNIT_CMD		0x04
> > > >>>>+#define ATAPI_INQUIRY_CMD		0x12
> > > >>>
> > > >>>
> > > >>>[snip]
> > > >>>
> > > >>>We already have the "full" list in cdrom.h (GPCMD_*), so lets just use
> > > >>>that. After all, ATAPI_MODE_SELECT10_CMD _is_ the same as the SCSI
> > > >>>variant (and I think the _CMD post fixing is silly, anyone familiar with
> > > >>>this is going to know what ATAPI_WRITE10 means just fine)
> > > >>>
> > > >>>Same for request_sense, that is already generalized in cdrom.h as well.
> > > >>
> > > >>I wonder what FreeBSD is using here? I see no need for invention at
> > > >>this place.
> > > >
> > > >
> > > > The invention would be adding the ATAPI_* commands, Linux has used the
> > > > GPCMD_ convention for quite some time now.
> > >
> > > Agreed. The ATAPI prefix would be confusing, since those are in reality SCSI
> > > commands anyway...
> >
> > I think we should use scsi.h and get rid of GPCMD_* convention also.
> > Jens, do you want "corrected" patch?
>
> Note that GPCMD_ is exported to user land, and several programs are
> using them for quite some time. So GPCMD_ stays, and that's final.
>

There was some discussion that user land should not include linux/ headers
directly, so in long term user land should be fixed not to use GPCMD_* ...



