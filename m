Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbUEVToO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbUEVToO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 15:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbUEVToN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 15:44:13 -0400
Received: from cmlapp16.siteprotect.com ([64.41.126.229]:11416 "EHLO
	cmlapp16.siteprotect.com") by vger.kernel.org with ESMTP
	id S261880AbUEVToK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 15:44:10 -0400
Message-ID: <40AFAD8E.9080008@serice.net>
Date: Sat, 22 May 2004 14:44:14 -0500
From: Paul Serice <paul@serice.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040127
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iso9660 inodes beyond 4GB
References: <40AD2F8A.6030306@serice.net> <20040521190602.511d188e.akpm@osdl.org>
In-Reply-To: <20040521190602.511d188e.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Dumb question: why not simply use a 64-bit type in the inode?

I wasn't sure how to proceed in this direction, but I'll give it
another shot.

It seems natural to use the lower 32 bits as the inode number in this
case, but in general, I'm not sure what precautions I need to take
when switching from a unique inode number to a non-unique inode
number.

For example, at fs/isofs/inode.c:131, the comment warns that the
current isofs code supports NFS implicitly because iget() works.
Because I think I will have to use iget5_locked() now instead of
iget(), I think I stand a good chance of breaking whatever NFS support
is currently available.



 >>The patch is about 28K and can be downloaded from the following URL:
 >>
 >>     http://www.serice.net/shunt/linux-2.6.6-isofs.patch
 >
 > It goes 404.  Please just send the patch directly to the mailing
 > list.

Sorry.  I didn't think my post(s) made it to the list.  So, I took the
patch down.

