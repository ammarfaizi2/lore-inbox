Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312357AbSDSMZQ>; Fri, 19 Apr 2002 08:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312411AbSDSMZQ>; Fri, 19 Apr 2002 08:25:16 -0400
Received: from pat.uio.no ([129.240.130.16]:5813 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S312357AbSDSMZP>;
	Fri, 19 Apr 2002 08:25:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Organization: Dept. of Physics, University of Oslo
To: "Jehanzeb Hameed" <u990056@giki.edu.pk>
Subject: Re: regarding NFS
Date: Fri, 19 Apr 2002 14:24:57 +0200
X-Mailer: KMail [version 1.3.2]
Cc: "Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0204181338050.19147-100000@penguin.transmeta.com> <shs7kn4m3mk.fsf@charged.uio.no> <004801c1e740$3edb09b0$e53ca8c0@hostel6.resnet.giki.edu.pk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16yXRh-0005k9-00@charged.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19. April 2002 03:19, Jehanzeb Hameed wrote:
> In inode.c inside code for NFS says :
>  inode->i_data.a_ops = &nfs_file_aops;
>
> it's still not  "inode->i_mapping->a_ops "!!!!!!
>
>  it should, somewhere, assign something to  inode->i_mapping->a_ops ?????

No. inode->i_mapping is initialized by the VFS, not the NFS client 
filesystem. (see linux/fs/inode.c:clean_inode())

Cheers,
  Trond
