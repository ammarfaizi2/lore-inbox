Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285831AbRLHFAo>; Sat, 8 Dec 2001 00:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285830AbRLHFAf>; Sat, 8 Dec 2001 00:00:35 -0500
Received: from zok.SGI.COM ([204.94.215.101]:39881 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S285826AbRLHFAP>;
	Sat, 8 Dec 2001 00:00:15 -0500
Date: Sat, 8 Dec 2001 15:58:41 +1100
From: Nathan Scott <nathans@sgi.com>
To: "Stephen C . Tweedie" <sct@redhat.com>,
        Andreas Gruenbacher <ag@bestbits.at>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@oss.sgi.com
Subject: Re: [PATCH] Revised extended attributes interface
Message-ID: <20011208155841.A56289@wobbly.melbourne.sgi.com>
In-Reply-To: <20011205143209.C44610@wobbly.melbourne.sgi.com> <20011207202036.J2274@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011207202036.J2274@redhat.com>; from sct@redhat.com on Fri, Dec 07, 2001 at 08:20:36PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2001 at 08:20:36PM +0000, Stephen C. Tweedie wrote:
> Hi,
> 

hi Stephen,

> This is looking OK as far as EAs go.  However, there is still no
> mention of ACLs specifically, except an oblique reference to
> "system.posix_acl_access".  

Yup - there's little mention of ACLs because they are only an
optional, higher-level consumer of the API, & so didn't seem
appropriate to document here.

We have implemented POSIX ACLs above this interface - there
is source to new versions of Andreas' user tools here:
http://oss.sgi.com/cgi-bin/cvsweb.cgi/linux-2.4-xfs/cmd/acl2
These have been tested with XFS and seem to work fine, so we
are ready to transition over from our old implementation to
this new one.

In a way there's consensus wrt how to do POSIX ACLs on Linux
now, as both the ext2/ext3 and XFS ACL projects will be using
the same tools, libraries, etc.  In terms of other ACL types,
I don't know of anyone actively working on any.

The existence of a POSIX ACL implementation using attributes
system.posix_acl_access and system.posix_acl_default doesn't
preclude other types of ACLs from being implemented (obviously
using different attributes) as well of course, if someone had
an itch to scratch.

cheers.

-- 
Nathan
