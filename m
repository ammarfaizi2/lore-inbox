Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263032AbTDRMsJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 08:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263035AbTDRMsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 08:48:09 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:56588 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263032AbTDRMsI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 08:48:08 -0400
Date: Fri, 18 Apr 2003 15:01:44 +0200
To: John Bradford <john@grabjohn.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Benefits from computing physical IDE disk geometry?
Message-ID: <20030418130144.GA14042@hh.idb.hist.no>
References: <1050244174.24187.15.camel@dhcp22.swansea.linux.org.uk> <200304131615.h3DGFp7t000811@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304131615.h3DGFp7t000811@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.5.3i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 13, 2003 at 05:15:51PM +0100, John Bradford wrote:
> Is the basic assumption that lower block numbers are generally located
> in zones nearer the outside of the disk still true, though?  I.E. do
> you know of any disks that 'start from the middle'?  I usually
> recommend that people place their swap and /var partitions near the
> beginning of the disk, (for a _slight_ improvement), but maybe there
> is a good reason not to do this for some disks?

I generally put swap in the middle of the disk, not on the
"fastest" end.  The "fast" end is faster for large transfers,
but that isn't what swap is about.

Swap tends to have lots of small transfers now and then, in between
other io.  So you want a short seek from wherever the
access arm is to keep latency down, and the middle of the
disk has short way both from inner and outer tracks.

Helge Hafting
