Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbTLBRk4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 12:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbTLBRk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 12:40:56 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:39179
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S262446AbTLBRky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 12:40:54 -0500
Date: Tue, 2 Dec 2003 09:40:48 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Greg Stark <gsstark@mit.edu>
Cc: Erik Steffl <steffl@bigfoot.com>, linux-kernel@vger.kernel.org
Subject: Re: libata in 2.4.24?
Message-ID: <20031202174048.GQ1566@mis-mike-wstn.matchmail.com>
Mail-Followup-To: Greg Stark <gsstark@mit.edu>,
	Erik Steffl <steffl@bigfoot.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0312010836130.13692-100000@logos.cnet> <3FCB8312.3050703@rackable.com> <87fzg4ckej.fsf@stark.dyndns.tv> <3FCBB15F.7050505@rackable.com> <3FCBB9F1.2080300@bigfoot.com> <87n0abbx2k.fsf@stark.dyndns.tv> <20031202055336.GO1566@mis-mike-wstn.matchmail.com> <20031202055852.GP1566@mis-mike-wstn.matchmail.com> <87zneb9o5q.fsf@stark.dyndns.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zneb9o5q.fsf@stark.dyndns.tv>
User-Agent: Mutt/1.5.4i
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
> 
> Because one of the long-standing issues with IDE drives and Postgres is the
> fact that even after issuing an fsync the data may be sitting in the drive's
> buffer. This doesn't happen with SCSI because the drives aren't forced to lie
> about the data being on disk in order to handle subsequent requests. Turning
> off write-caching on IDE drives absolutely destroys performance.

There are PATA drives that do TCQ too, but you have to look for that feature
specifically.  IDE TCQ is in 2.6, but is still experemental.  I think Jens
Axboe was the one working on it IIRC.  He would have more details.

> 
> Do the new SATA drives and controllers provide a solution to this?

It's not SATA specific, and I'm not sure if any ide controller can support
TCQ or if only a specific list are compatible.

Mike
