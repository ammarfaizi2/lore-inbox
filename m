Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbWDTS16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWDTS16 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 14:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbWDTS16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 14:27:58 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:34515 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1750768AbWDTS15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 14:27:57 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Thu, 20 Apr 2006 19:27:49 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Zach Brown <zach.brown@oracle.com>
cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       steved@redhat.com, sct@redhat.com, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] FS-Cache: Add notification of page becoming writable
 to VMA ops
In-Reply-To: <4447C791.2070901@oracle.com>
Message-ID: <Pine.LNX.4.64.0604201926180.19187@hermes-1.csi.cam.ac.uk>
References: <20060420165927.9968.33912.stgit@warthog.cambridge.redhat.com>
 <20060420165930.9968.60742.stgit@warthog.cambridge.redhat.com>
 <4447C791.2070901@oracle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Apr 2006, Zach Brown wrote:
> David Howells wrote:
> > The attached patch adds a new VMA operation to notify a filesystem or other
> > driver about the MMU generating a fault because userspace attempted to write
> > to a page mapped through a read-only PTE.
> 
> This will almost certainly help OCFS2 get shared writable mmap() right,
> too, though it probably won't be the whole story.

This is also required by NTFS for a correct implementation of "mmap write 
into sparse region on ntfs volume with cluster size > PAGE_CACHE_SIZE".

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer, http://www.linux-ntfs.org/
