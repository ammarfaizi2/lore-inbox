Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264147AbUFCO46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbUFCO46 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 10:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264108AbUFCOxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 10:53:11 -0400
Received: from [63.225.89.126] ([63.225.89.126]:38017 "EHLO lade.trondhjem.org")
	by vger.kernel.org with ESMTP id S265550AbUFCOtc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 10:49:32 -0400
Subject: Re: [PATCH/RFC] Lustre VFS patch, version 2
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
       "Peter J. Braam" <braam@clusterfs.com>, linux-kernel@vger.kernel.org,
       axboe@suse.de, kevcorry@us.ibm.com, arjanv@redhat.com,
       iro@parcelfarce.linux.theplanet.co.uk, anton@samba.org,
       lustre-devel@clusterfs.com
In-Reply-To: <20040603141922.GI4423@marowsky-bree.de>
References: <20040602231554.ADC7B3100AE@moraine.clusterfs.com>
	 <20040603135952.GB16378@infradead.org>
	 <20040603141922.GI4423@marowsky-bree.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1086274140.3798.37.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 03 Jun 2004 07:49:01 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På to , 03/06/2004 klokka 07:19, skreiv Lars Marowsky-Bree:
> The hooks (once cleaned up, no disagreement here, the technical feedback
> so far has been very valuable and continues to be) are useful and in
> effect needed not just for Lustre, but in principle for all cluster
> filesystems, such as (Open)GFS and others, even potentially NFS4 et al.
> 
> The logic that _all_ modules and functionality need to be "in the tree"
> right from the start for hooks to be useful is flawed, I'm afraid. Pure
> horror that a proprietary cluster file system might also profit from it
> is not, exactly, a sound technical argument. (I can assure you I don't
> care at all for the proprietary cluster-fs.)

Whereas I agree that NFSv4 could use some of this (I'm mainly interested
in the intent_release() stuff in order to fix up an existing race), I
also agree with Christoph on the principle that having in-tree users
right from the start should be the norm rather than the exception.

Otherwise, exactly what is the plan for how to determine when an
interface is obsolete? Are we going to rely on all the out-of-tree
vendors to collectively step up and say "by the way - we're not using
this anymore."?

Cheers,
  Trond
