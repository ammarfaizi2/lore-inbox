Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbTLBSFg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 13:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262725AbTLBSFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 13:05:00 -0500
Received: from havoc.gtf.org ([63.247.75.124]:36499 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262687AbTLBSDX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 13:03:23 -0500
Date: Tue, 2 Dec 2003 13:02:42 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Greg Stark <gsstark@mit.edu>
Cc: Mike Fedyk <mfedyk@matchmail.com>, Erik Steffl <steffl@bigfoot.com>,
       linux-kernel@vger.kernel.org
Subject: Re: libata in 2.4.24?
Message-ID: <20031202180241.GB1990@gtf.org>
References: <Pine.LNX.4.44.0312010836130.13692-100000@logos.cnet> <3FCB8312.3050703@rackable.com> <87fzg4ckej.fsf@stark.dyndns.tv> <3FCBB15F.7050505@rackable.com> <3FCBB9F1.2080300@bigfoot.com> <87n0abbx2k.fsf@stark.dyndns.tv> <20031202055336.GO1566@mis-mike-wstn.matchmail.com> <20031202055852.GP1566@mis-mike-wstn.matchmail.com> <87zneb9o5q.fsf@stark.dyndns.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zneb9o5q.fsf@stark.dyndns.tv>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 02, 2003 at 11:31:45AM -0500, Greg Stark wrote:
> 
> Mike Fedyk <mfedyk@matchmail.com> writes:
> 
> > > Libata, uses the scsi system instead of the existing ide layer because many
> > > new sata controllers are using an interface that is very similair to scsi
> > > (much like atapi).
> 
> Now I have a different question. Does the scsi-like SATA interface include tcq?

Yes, it does.  But it depends on whether or not the host controller
supports TCQ.


> Because one of the long-standing issues with IDE drives and Postgres is the
> fact that even after issuing an fsync the data may be sitting in the drive's
> buffer.

If true, this is an IDE driver bug...  assuming the drive itself
doesn't lie about FLUSH CACHE results (a few do).


> This doesn't happen with SCSI because the drives aren't forced to lie
> about the data being on disk in order to handle subsequent requests. Turning
> off write-caching on IDE drives absolutely destroys performance.

If the drive lies, there isn't a darned thing we can do about it...


> Do the new SATA drives and controllers provide a solution to this?

If the drive lies, there isn't a darned thing the controller can do
about it, either ;-)

	Jeff



