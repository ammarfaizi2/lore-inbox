Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312194AbSDSJhp>; Fri, 19 Apr 2002 05:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312212AbSDSJho>; Fri, 19 Apr 2002 05:37:44 -0400
Received: from mons.uio.no ([129.240.130.14]:51343 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S312194AbSDSJho>;
	Fri, 19 Apr 2002 05:37:44 -0400
To: "Jehanzeb Hameed" <u990056@giki.edu.pk>
Cc: "Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: regarding NFS
In-Reply-To: <Pine.LNX.4.33.0204181338050.19147-100000@penguin.transmeta.com>
	<001f01c1e6c6$2d6a9f80$e53ca8c0@hostel6.resnet.giki.edu.pk>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 19 Apr 2002 11:36:35 +0200
Message-ID: <shs7kn4m3mk.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Jehanzeb Hameed <u990056@giki.edu.pk> writes:

     > I was looking at the code and I couldnt find how NFS implements
     > inode->i_mapping->a_ops->readpage(filp,page) in
     > used by generic_file_read in mm/filemapc.c. All I could find
     > was inode->i_op->readpage(filp,page). But NFS uses
     > generic_file_read....so how does it work out. Kernel 2.4.17??

Look again: there is no such thing as readpage() in the struct
inode_operations in the 2.4.x kernels. Just grep for 'nfs_file_aops'
in the source.

Cheers,
  Trond
