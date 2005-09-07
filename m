Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbVIGM6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbVIGM6m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 08:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbVIGM6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 08:58:42 -0400
Received: from tama5.ecl.ntt.co.jp ([129.60.39.102]:29832 "EHLO
	tama5.ecl.ntt.co.jp") by vger.kernel.org with ESMTP
	id S1751135AbVIGM6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 08:58:41 -0400
To: boutcher@cs.umn.edu
Cc: hch@lst.de, vst@vlnb.net, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       santil@us.ibm.com, lxiep@us.ibm.com
Subject: Re: [RFC] SCSI target for IBM Power5 LPAR
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <20050907124504.GA13614@cs.umn.edu>
References: <20050906212801.GB14057@cs.umn.edu>
	<20050907104932.GA14200@lst.de>
	<20050907124504.GA13614@cs.umn.edu>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050907215816C.fujita.tomonori@lab.ntt.co.jp>
Date: Wed, 07 Sep 2005 21:58:16 +0900
X-Dispatcher: imput version 20040704(IM147)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave C Boutcher <sleddog@us.ibm.com>
Subject: Re: [RFC] SCSI target for IBM Power5 LPAR
Date: Wed, 7 Sep 2005 07:45:04 -0500

> On Wed, Sep 07, 2005 at 12:49:32PM +0200, Christoph Hellwig wrote:
> > On Tue, Sep 06, 2005 at 04:28:01PM -0500, Dave C Boutcher wrote:
> > > This device driver provides the SCSI target side of the "virtual
> > > SCSI" on IBM Power5 systems.  The initiator side has been in mainline
> > > for a while now (drivers/scsi/ibmvscsi/ibmvscsi.c.)  Targets already
> > > exist for AIX and OS/400.
> > 
> > Please try to integrate that with the generic scsi target framework at
> > http://developer.berlios.de/projects/stgt/.
> 
> There hasn't been a lot of forward progress on stgt in over a year, and
> there were some issues (lack of scatterlist support, synchronous and
> serial command execution) that were an issue when last I looked.

The generic scsi target framework (stgt) is not SCST (that Vlad has
maintained). It is the project that Mike Christie and I started last
month. We discussed it with Christoph and decided that it would be
better to start from scratch because of the design differences.
