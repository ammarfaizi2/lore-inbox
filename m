Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbWFBFyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbWFBFyr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 01:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbWFBFyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 01:54:47 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:51976 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751059AbWFBFyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 01:54:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=bXMtMhBvcTFFUHDX2TL/Sd2P2HoCPjlt6ANIl9RrHenF0+admschscpGPnNvbKFwXxfgWzZoPhn8CTry84Fbrtuwt1/RSm35M7RqyQz5uz8zSb3V4wHMg7EFrQ7yM7SBjIVjbtT3QvGl5Oj6JK1+Tb8U1j6D+4vQ410GjDxRDkc=
Message-ID: <4ae3c140606012254i5fa92953rdd1ea229be9a02f9@mail.gmail.com>
Date: Fri, 2 Jun 2006 01:54:45 -0400
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Why NFS enforce size limit on readdirplus
Cc: linux-fsdevel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe this question is a little dumb.

I am wondering why in NFS readdirplus can be used only for directories
of size less than 8*PAGE_SIZE, otherwise, it will switch to use normal
readdir?

In nfs/inode.c, I noticed the following code:
			    if (nfs_server_capable(inode, NFS_CAP_READDIRPLUS) &&
fattr->size <= NFS_LIMIT_READDIRPLUS)
				    set_bit(NFS_INO_ADVISE_RDPLUS, &NFS_FLAGS(inode));

Can someone kindly explain the reason?

Thanks a lot!

Xin
