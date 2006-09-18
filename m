Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965328AbWIRDfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965328AbWIRDfL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 23:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWIRDfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 23:35:08 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:61845 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751354AbWIRDfD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 23:35:03 -0400
Date: Mon, 18 Sep 2006 13:34:31 +1000
From: David Chinner <dgc@sgi.com>
To: "Josef 'Jeff' Sipek" <jeffpc@josefsipek.net>
Cc: linux-kernel@vger.kernel.org, xfs-masters@oss.sgi.com, akpm@osdl.org,
       dhowells@redhat.com
Subject: Re: [PATCH 5 of 11] XFS: Use SEEK_{SET, CUR, END} instead of hardcoded values
Message-ID: <20060918033431.GV3034@melbourne.sgi.com>
References: <patchbomb.1158455366@turing.ams.sunysb.edu> <4cdee5980dad9980ec8f.1158455371@turing.ams.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cdee5980dad9980ec8f.1158455371@turing.ams.sunysb.edu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 16, 2006 at 09:09:31PM -0400, Josef 'Jeff' Sipek wrote:
> XFS: Use SEEK_{SET,CUR,END} instead of hardcoded values

The hard coded values  used in xfs_change_file_space() are documented as part
of the API to the userspace functions that use this interface in xfsctl(3).
That is:

  XFS_IOC_FREESP
  XFS_IOC_FREESP64
  XFS_IOC_ALLOCSP
  XFS_IOC_ALLOCSP64

  Alter storage space associated with a section of the ordinary file specified.
  The section is specified by a variable of type  xfs_flock64_t,  pointed  to  by
  the  final argument.  The data type xfs_flock64_t contains the following
  members: l_whence is 0, 1, or 2 to indicate that the relative offset l_start
  will be measured from the start  of  the  file,  the current  position, or the
  end of the file, respectively.

Hence I think that the hard coded values should not be changed to something
that is defined outside of XFS's API.

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
