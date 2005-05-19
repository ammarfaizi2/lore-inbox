Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262438AbVESBa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbVESBa5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 21:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262435AbVESBag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 21:30:36 -0400
Received: from agminet03.oracle.com ([141.146.126.230]:20912 "EHLO
	agminet03.oracle.com") by vger.kernel.org with ESMTP
	id S262438AbVESBaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 21:30:21 -0400
Date: Wed, 18 May 2005 18:26:58 -0700
From: Manish Singh <manish.singh@oracle.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Mark Fasheh <mark.fasheh@oracle.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org,
       linux-fsdevel@vger.kernel.org, ocfs2-devel@oss.oracle.com
Subject: Re: [Ocfs2-devel] Re: [RFC] [PATCH] OCFS2
Message-ID: <20050519012658.GA27595@ca-server1.us.oracle.com>
Reply-To: Manish Singh <manish.singh@oracle.com>
References: <20050518223303.GE1340@ca-server1.us.oracle.com> <20050518234022.GA5112@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050518234022.GA5112@stusta.de>
Organization: Oracle
X-Unexpected-Header: Hah! Nobody expects the unexpected header!
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2005 at 01:40:22AM +0200, Adrian Bunk wrote:
> On Wed, May 18, 2005 at 03:33:03PM -0700, Mark Fasheh wrote:
> >...
> > A full patch can be downloaded from:
> > http://oss.oracle.com/projects/ocfs2/dist/files/patches/2.6.12-rc4/complete/ocfs2-configfs-all.patch
> >...
> 
> Some comments on this patch:
> - there's no reason to make JBD user-visible

Sure, the only reason I made it visible was because of the comment in
there:

# CONFIG_JBD could be its own option (even modular), but until there are
# other users than ext3, we will simply make it be the same as CONFIG_EXT3_FS

I don't really have a preference either way.

> - is there any reason why CONFIGFS_FS is user-visible?

It's a generic mechanism for userspace driven configuration of kernel
functionality. There's nothing specific to OCFS2 about it. Other kernel
subsystems/projects could use it too, for their own configuration
mechanisms. More details are in configfs.txt, which is included in the
above patch. Note the example used in the documentation text is an NBD
driver.

> - some global code might become static:
>   run "make namespacecheck" after compiling the kernel and check
>   the configfs and ocfs2 parts of the output

Yeah, there's some stuff that that scripts catches. Thanks.

-Manish

