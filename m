Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751416AbWHIW4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWHIW4b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 18:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbWHIW4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 18:56:31 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:55722 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751416AbWHIW4a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 18:56:30 -0400
Date: Thu, 10 Aug 2006 08:56:16 +1000
From: Nathan Scott <nathans@sgi.com>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: XFS warning in 2.6.18-rc4
Message-ID: <20060810085616.C2581413@wobbly.melbourne.sgi.com>
References: <Pine.SOC.4.61.0608092303570.27011@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.SOC.4.61.0608092303570.27011@math.ut.ee>; from mroos@linux.ee on Wed, Aug 09, 2006 at 11:04:53PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 11:04:53PM +0300, Meelis Roos wrote:
> fs/xfs/xfs_bmap.c: In function 'xfs_bmapi':
> fs/xfs/xfs_bmap.c:2662: warning: 'rtx' is used uninitialized in this function

You have a particularly dense compiler, unfortunately.  This code
has always been this way, its just a false cc warning that can be
safely ignored until you upgrade to a fixed compiler (unless I'm
missing something - please enlighten me if so).  It does seem to
be the case that there is no way 'rtx' will be used uninitialised
when xfs_rtpick_extent() doesn't fail... no?

cheers.

-- 
Nathan
