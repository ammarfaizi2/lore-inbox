Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbWBWN45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbWBWN45 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 08:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWBWN45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 08:56:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:25250 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751235AbWBWN44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 08:56:56 -0500
Date: Thu, 23 Feb 2006 13:56:39 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: device-mapper development <dm-devel@redhat.com>,
       Chris McDermott <lcm@us.ibm.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [dm-devel] Re: [PATCH] User-configurable HDIO_GETGEO for dm volumes
Message-ID: <20060223135639.GK31641@agk.surrey.redhat.com>
Mail-Followup-To: "Darrick J. Wong" <djwong@us.ibm.com>,
	device-mapper development <dm-devel@redhat.com>,
	Chris McDermott <lcm@us.ibm.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <43F38D83.3040702@us.ibm.com> <20060217151650.GC12173@agk.surrey.redhat.com> <43F6718E.2000908@us.ibm.com> <20060222223240.GI31641@agk.surrey.redhat.com> <1140655617.3300.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140655617.3300.14.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 04:46:57PM -0800, Darrick J. Wong wrote:
> Looks good and tests ok, with one issue: I still have a preference for
> returning -ENOTTY over 0/0/0 when dm doesn't know the geometry.  That
> said, most programs will see the zero cylinder count and make a guess,
> so it probably doesn't matter.
 
My copy of the sd(4) man page says of that ioctl:

    The information returned in the parameter is the disk
    geometry of the drive as understood by DOS!   This geometry is not
    the physical geometry of the drive.  It is used when constructing the
    drive's partition table, however, and is needed for convenient
    operation of fdisk(1), efdisk(1), and lilo(1).  If the geometry
    information is not available, zero will be returned for all of the
    parameters.
 
Is there a preferred alternative specification?

Alasdair
-- 
agk@redhat.com
