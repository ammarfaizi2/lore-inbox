Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264932AbTFLSMd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 14:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264937AbTFLSMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 14:12:32 -0400
Received: from air-2.osdl.org ([65.172.181.6]:18135 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264934AbTFLSMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 14:12:31 -0400
Subject: Re: ext[23]/lilo/2.5.{68,69,70} -- blkdev_put() problem?
From: Andy Pfiffer <andyp@osdl.org>
To: Andrew Morton <akpm@digeo.com>
Cc: christophe@saout.de, adam@yggdrasil.com, linux-kernel@vger.kernel.org
In-Reply-To: <1055441028.1202.11.camel@andyp.pdx.osdl.net>
References: <1052507057.15923.31.camel@andyp.pdx.osdl.net>
	 <1052510656.6334.8.camel@chtephan.cs.pocnet.net>
	 <1052513725.15923.45.camel@andyp.pdx.osdl.net>
	 <1055369326.1158.252.camel@andyp.pdx.osdl.net>
	 <1055373692.16483.8.camel@chtephan.cs.pocnet.net>
	 <1055377253.1222.8.camel@andyp.pdx.osdl.net>
	 <20030611172958.5e4d3500.akpm@digeo.com>
	 <1055438856.1202.6.camel@andyp.pdx.osdl.net>
	 <20030612105347.6ea644b7.akpm@digeo.com>
	 <1055441028.1202.11.camel@andyp.pdx.osdl.net>
Content-Type: text/plain
Organization: 
Message-Id: <1055442331.1225.11.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 12 Jun 2003 11:25:31 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-12 at 11:03, Andy Pfiffer wrote:
> On Thu, 2003-06-12 at 10:53, Andrew Morton wrote:
> > Andy Pfiffer <andyp@osdl.org> wrote:
> > >
> > > Dirty:               0 kB	Dirty:               4 kB <---
> > 
> > OK.  And are you using initrd as well?
> 
> It is specified in lilo.conf (SuSE 8.0 distro) but I don't see any
> reason to keep it.  I'll yank it and see if it makes a difference.

pure == 2.5.68
kludge == 2.5.68+kludge in blkdev_put()

% grep Dirt =noinitrd-*
=noinitrd-kludge=:Dirty:               0 kB   # before
=noinitrd-kludge=:Dirty:               4 kB   # after
=noinitrd-pure=:Dirty:               0 kB     # before
=noinitrd-pure=:Dirty:               4 kB     # after

So it would appear to me that initrd is the common denominator among
those of us reporting similar symptoms.

Andy




