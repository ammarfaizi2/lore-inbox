Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264352AbUFCOUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264352AbUFCOUZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 10:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264382AbUFCOUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 10:20:24 -0400
Received: from gate.in-addr.de ([212.8.193.158]:60362 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S264352AbUFCOUJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 10:20:09 -0400
Date: Thu, 3 Jun 2004 16:19:22 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Christoph Hellwig <hch@infradead.org>,
       "Peter J. Braam" <braam@clusterfs.com>, linux-kernel@vger.kernel.org,
       axboe@suse.de, kevcorry@us.ibm.com, arjanv@redhat.com,
       iro@parcelfarce.linux.theplanet.co.uk, trond.myklebust@fys.uio.no,
       anton@samba.org, lustre-devel@clusterfs.com
Subject: Re: [PATCH/RFC] Lustre VFS patch, version 2
Message-ID: <20040603141922.GI4423@marowsky-bree.de>
References: <20040602231554.ADC7B3100AE@moraine.clusterfs.com> <20040603135952.GB16378@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040603135952.GB16378@infradead.org>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-06-03T14:59:52,
   Christoph Hellwig <hch@infradead.org> said:

> > Well, how close are we now to this being acceptable?
> As already mentioned above they're completely uninteresting without
> actually getting the user in tree _and_ maintained there (unlike e.g.
> intermezzo or coda that are creeping along).  I think based on those
> patch we should be able to properly integrate intermezzo once 2.7 opens.

This is something I've got to disagree with.

First, Inter-mezzo is reasonably dead, from what I can see. As is Coda.
You'll notice that the developers behind them have sort-of moved on to
Lustre ;-)

The hooks (once cleaned up, no disagreement here, the technical feedback
so far has been very valuable and continues to be) are useful and in
effect needed not just for Lustre, but in principle for all cluster
filesystems, such as (Open)GFS and others, even potentially NFS4 et al.

The logic that _all_ modules and functionality need to be "in the tree"
right from the start for hooks to be useful is flawed, I'm afraid. Pure
horror that a proprietary cluster file system might also profit from it
is not, exactly, a sound technical argument. (I can assure you I don't
care at all for the proprietary cluster-fs.)

Lustre alone would be, roughly, ~10MB more sources, just in the kernel.
I don't think you want to merge that right now, as desireable as it is
on the other hand to be able to use it with a mainstream kernel. I think
this is why kbuild allows external modules to be build; with that logic
it would follow that this should be disabled too.

There certainly is an interest in merging these (cleaned up) extensions
and allowing powerful cluster filesystems to exist on Linux.

Another example of this is the cache invalidation hook which we went
through a few weeks ago too. Back then you complained about not having
an Open Source user (because it was requested by IBM GPFS), and so
GFS/OpenGFS chimed in - now it is the lack of an _in-tree_ Open Source
user...


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	      \ ever tried. ever failed. no matter.
SUSE Labs			      | try again. fail again. fail better.
Research & Development, SUSE LINUX AG \ 	-- Samuel Beckett

