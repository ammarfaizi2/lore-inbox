Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265656AbUAMVGx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 16:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265659AbUAMVGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 16:06:43 -0500
Received: from intra.cyclades.com ([64.186.161.6]:12435 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265656AbUAMVGb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 16:06:31 -0500
Date: Tue, 13 Jan 2004 18:55:14 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Doug Ledford <dledford@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Arjan Van de Ven <arjanv@redhat.com>,
       Martin Peschke3 <MPESCHKE@de.ibm.com>, Jens Axboe <axboe@suse.de>,
       Peter Yao <peter@exavio.com.cn>, linux-kernel@vger.kernel.org,
       linux-scsi mailing list <linux-scsi@vger.kernel.org>, ihno@suse.de
Subject: Re: smp dead lock of io_request_lock/queue_lock patch
In-Reply-To: <1073937102.3114.300.camel@compaq.xsintricity.com>
Message-ID: <Pine.LNX.4.58L.0401131843390.6737@logos.cnet>
References: <OF317B32D5.C8C681CB-ONC1256E19.005066CF-C1256E19.00538DEF@de.ibm.com>
  <20040112151230.GB5844@devserv.devel.redhat.com>  <20040112194829.A7078@infradead.org>
 <1073937102.3114.300.camel@compaq.xsintricity.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 12 Jan 2004, Doug Ledford wrote:

> On Mon, 2004-01-12 at 14:48, Christoph Hellwig wrote:
> > On Mon, Jan 12, 2004 at 04:12:30PM +0100, Arjan van de Ven wrote:
> > > > as the patch discussed in this thread, i.e. pure (partially
> > > > vintage) bugfixes.
> > >
> > > Both SuSE and Red Hat submit bugfixes they put in the respective trees to
> > > marcelo already. There will not be many "pure bugfixes" that you can find in
> > > vendor trees but not in marcelo's tree.
> >
> > I haven't seen SCSI patches sumission for 2.4 from the vendors on linux-scsi
> > for ages.  In fact I asked Jens & Doug two times whether they could sort out
> > the distro patches for the 2.4 stack and post them, but it seems they're busy
> > enough with real work so this never happened.
>
> More or less.  But part of it also is that a lot of the patches I've
> written are on top of other patches that people don't want (aka, the
> iorl patch).  I've got a mlqueue patch that actually *really* should go
> into mainline because it solves a slew of various problems in one go,
> but the current version of the patch depends on some semantic changes
> made by the iorl patch.  So, sorting things out can sometimes be
> difficult.  But, I've been told to go ahead and do what I can as far as
> getting the stuff out, so I'm taking some time to try and get a bk tree
> out there so people can see what I'm talking about.  Once I've got the
> full tree out there, then it might be possible to start picking and
> choosing which things to port against mainline so that they don't depend
> on patches like the iorl patch.

Hi,

Merging "straight" _bugfixes_ (I think all we agree that merging
performance enhancements at this point in 2.4 is not interesting) which,
as you said, get reviewed by Jens/James/others is OK.

What is this mlqueue patchset fixing ? To tell you the truth, I'm not
aware of the SCSI stack problems.
