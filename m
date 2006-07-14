Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161299AbWGNUuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161299AbWGNUuM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 16:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161124AbWGNUuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 16:50:11 -0400
Received: from igw2.watson.ibm.com ([129.34.20.6]:60860 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP
	id S1161299AbWGNUuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 16:50:09 -0400
Subject: Re: [RFC][PATCH 3/6] SLIM main patch
From: David Safford <safford@watson.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Kylene Jo Hall <kjhall@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
In-Reply-To: <1152905691.314.62.camel@localhost.localdomain>
References: <1152897878.23584.6.camel@localhost.localdomain>
	 <1152901664.314.35.camel@localhost.localdomain>
	 <1152905158.23584.35.camel@localhost.localdomain>
	 <1152905691.314.62.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 16:51:13 -0400
Message-Id: <1152910274.2415.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-14 at 12:34 -0700, Dave Hansen wrote:
> On Fri, 2006-07-14 at 12:25 -0700, Kylene Jo Hall wrote:
> > > inode_supports_xaddr()?  Seems like something that should check a
> > > superblock flag or something.
> > 
> > I don't know of any such flags.
> 
> There probably aren't any.  The superblock may not even be the right
> place for it.  It just seems a bit silly to say that the only files in
> the system that don't support xaddrs are device files and /proc.  What
> about all of the other filesystems?  Have you tested things like
> ISO9660, VFAT, sysfs?

is_exempt() is just a quick test to speed up a couple of obvious cases. 
It does not need to be complete, as the subsequent get_level() will handle
all other cases where xattrs are not supported....

dave

