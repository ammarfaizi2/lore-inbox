Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbTE0QDL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 12:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263925AbTE0QDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 12:03:11 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:27601
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S261994AbTE0QDK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 12:03:10 -0400
Date: Tue, 27 May 2003 12:16:24 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCHES] add ata scsi driver
Message-ID: <20030527161624.GC21744@gtf.org>
References: <Pine.LNX.4.44.0305270734320.20127-100000@home.transmeta.com> <1054047595.1975.64.camel@mulgrave> <20030527152113.GA21744@gtf.org> <1054049931.1975.129.camel@mulgrave> <20030527155053.GB21744@gtf.org> <1054051233.1975.139.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054051233.1975.139.camel@mulgrave>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 12:00:28PM -0400, James Bottomley wrote:
> On Tue, 2003-05-27 at 11:50, Jeff Garzik wrote:
> > Oh, no question.  My main interest is having a persistent id for a
> > device's media.  Then Linux can use that to allow mapping in case device
> > names or majors change at each boot (and similar situations).
> 
> Well, OK, that's not an in-kernel issue.

It's definitely an in-kernel issue, because the mapping is in-kernel now:

	<major,minor> -> queue


> My current thought for this is that deriving the unique name can be
> awfully device specific (even in SCSI there are several fallback methods
> plus the usual black/white list of things that don't quite return
> entirely unique objects).

Agreed.  And kernel assistance is likely necessary in many cases to
obtain the unique id, even if it's only userspace that's reading it.


> Thus, I think the derivation probably belongs
> in userspace as part of hotplug.  Once the unique ID is determined, it
> could be written to a well known place in the sysfs tree for all the
> rest of the OS (things like udev for persistent device naming) to use.

Agreed, with the above proviso.

	Jeff




