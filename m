Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263866AbTE0Prb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 11:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263867AbTE0Pra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 11:47:30 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:36102 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263866AbTE0Pra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 11:47:30 -0400
Subject: Re: [BK PATCHES] add ata scsi driver
From: James Bottomley <James.Bottomley@steeleye.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030527155053.GB21744@gtf.org>
References: <Pine.LNX.4.44.0305270734320.20127-100000@home.transmeta.com>
	<1054047595.1975.64.camel@mulgrave> <20030527152113.GA21744@gtf.org>
	<1054049931.1975.129.camel@mulgrave>  <20030527155053.GB21744@gtf.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 27 May 2003 12:00:28 -0400
Message-Id: <1054051233.1975.139.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-27 at 11:50, Jeff Garzik wrote:
> Oh, no question.  My main interest is having a persistent id for a
> device's media.  Then Linux can use that to allow mapping in case device
> names or majors change at each boot (and similar situations).

Well, OK, that's not an in-kernel issue.

My current thought for this is that deriving the unique name can be
awfully device specific (even in SCSI there are several fallback methods
plus the usual black/white list of things that don't quite return
entirely unique objects).  Thus, I think the derivation probably belongs
in userspace as part of hotplug.  Once the unique ID is determined, it
could be written to a well known place in the sysfs tree for all the
rest of the OS (things like udev for persistent device naming) to use.

James


