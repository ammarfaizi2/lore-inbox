Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264107AbUDRIRI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 04:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbUDRIRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 04:17:08 -0400
Received: from verein.lst.de ([212.34.189.10]:7114 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S264107AbUDRIRG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 04:17:06 -0400
Date: Sun, 18 Apr 2004 10:17:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] lockfs - vfs bits
Message-ID: <20040418081659.GA8972@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040417220632.GA2573@lst.de> <20040417163007.67d23c10.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040417163007.67d23c10.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2004 at 04:30:07PM -0700, Andrew Morton wrote:
> Christoph Hellwig <hch@lst.de> wrote:
> >
> >  These are the generic lockfs bits.  Basically it takes the XFS freezing
> >  statemachine into the VFS.  It's all behind the kernel-doc documented
> >  freeze_bdev and thaw_bdev interfaces.
> 
> Do we expect to see snapshotting patches for other filesystems arise as a
> result of this?

Other filesystems already implement the write_super_lockfs and unlockfs
methods and should just work.  An earlier version of this patch is in
SuSE's tree and I think they've tested it with ext3 and reiserfs.
Similarly even earlier variants are in the 2.4 vendor trees.  Those
filesystem don't really use the state machine to avoid starting new
transactions, so to get results as reliable as XFS they need soem more
work.

