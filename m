Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751514AbWHJUKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbWHJUKa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbWHJUKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:10:10 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:50613 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751154AbWHJUKF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 16:10:05 -0400
Subject: Re: [Ext2-devel] [PATCH 2/5] Register ext3dev filesystem
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Theodore Tso <tytso@mit.edu>, Erik Mouw <erik@harddisk-recovery.com>,
       Mingming Cao <cmm@us.ibm.com>, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <44DB8EBE.6060003@garzik.org>
References: <1155172642.3161.74.camel@localhost.localdomain>
	 <20060810092021.GB11361@harddisk-recovery.com>
	 <20060810175920.GC19238@thunk.org>  <44DB8EBE.6060003@garzik.org>
Content-Type: text/plain
Date: Thu, 10 Aug 2006 15:08:43 -0500
Message-Id: <1155240524.12082.14.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-10 at 15:53 -0400, Jeff Garzik wrote:
> Theodore Tso wrote:
> > On Thu, Aug 10, 2006 at 11:20:22AM +0200, Erik Mouw wrote:
> >> On Wed, Aug 09, 2006 at 06:17:22PM -0700, Mingming Cao wrote:
> >>> Register ext4 filesystem as ext3dev filesystem in kernel.
> >> Why confuse users with the name "ext3dev"? If a filesystem lives in
> >> fs/blah/, it's registered as "blah" and can be mounted with "-t blah".
> >> Just register the filesystem as "ext4" and mark it "EXPERIMENTAL" in
> >> Kconfig.
> > 
> > We had this discussion on LKML.  There were those who were concerned
> > that it would not be enough just to mark it be EXPERIMENTAL.
> 
> I _want_ to agree with Erik, but I must agree:  CONFIG_EXPERIMENTAL is 
> pretty worthless in practice :(  It's not maintained rigorously, and 
> distros _always_ enable it, because otherwise they would often omit key 
> drivers that people actively use.
> 
> So, while my own personal preference would be to follow Erik's 
> suggestion...  thinking realistically, an fstype change from "ext3dev" 
> to "ext4" is a far more obvious-to-users method of creating a 
> devel/production line of demarcation.

IF it's decided to register the file system as ext3dev (Would ext4dev
make more sense?), I would prefer the config options and code continues
to simply use ext4.
-- 
David Kleikamp
IBM Linux Technology Center

