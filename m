Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263796AbTDUJ1z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 05:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263798AbTDUJ1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 05:27:55 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:3712 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263796AbTDUJ1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 05:27:54 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304210942.h3L9gZ1W000282@81-2-122-30.bradfords.org.uk>
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
To: vda@port.imtp.ilyichevsk.odessa.ua
Date: Mon, 21 Apr 2003 10:42:35 +0100 (BST)
Cc: adilger@clusterfs.com (Andreas Dilger), john@grabjohn.com (John Bradford),
       skraw@ithnet.com (Stephan von Krawczynski),
       linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <200304210917.h3L9HIu07472@Port.imtp.ilyichevsk.odessa.ua> from "Denis Vlasenko" at Apr 21, 2003 12:25:28 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > > > I wonder whether it would be a good idea to give the linux-fs
> > > > > > (namely my preferred reiser and ext2 :-) some
> > > > > > fault-tolerance.
> >
> > I'm not against this in principle, but in practise it is almost
> > useless. Modern disk drives do bad sector remapping at write time, so
> > unless something is terribly wrong you will never see a write error
> > (which is exactly the time that the filesystem could do such
> > remapping).  Normally, you will only see an error like this at read
> > time, at which point it is too late to fix.
> 
> It is *not* useless.
> 
> I have at least 4 disks with some bad sectors. Know what?
> They are still in use in a school lab and as 'big diskettes'
> (transferring movies etc). I refuse to dump them just because
> 'todays disks are cheap'. I don't want my fs to die just because
> these disks develop (ohhhh) a single new bad sector.

Read my previous posts.

A layer between device and filesystem can solve this.  It doesn't
belong in the filesystem.

John.
