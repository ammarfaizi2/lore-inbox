Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272576AbRIKVc5>; Tue, 11 Sep 2001 17:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272577AbRIKVcq>; Tue, 11 Sep 2001 17:32:46 -0400
Received: from mercury.lss.emc.com ([168.159.40.77]:5130 "EHLO
	mercury.lss.emc.com") by vger.kernel.org with ESMTP
	id <S272576AbRIKVcc>; Tue, 11 Sep 2001 17:32:32 -0400
Message-ID: <276737EB1EC5D311AB950090273BEFDD043BC5A3@elway.lss.emc.com>
From: "chen, xiangping" <chen_xiangping@emc.com>
To: "'Trond Myklebust'" <trond.myklebust@fys.uio.no>
Cc: "'nfs-request@lists.sourceforge.net'" 
	<nfs-request@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
Subject: RE: Questions on NFS client inode management.
Date: Tue, 11 Sep 2001 17:25:46 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Trond

Thanks for the reply. What kind of reclaiming scheme is used by
NFS client and the Linux local file system, say ext2/ext3? 
Is it used for reclaiming the inode resources, or for memory
in general (like killing processes)?

Is there any benchmark available to test how many active inodes
a particular system can support?


Xiangping


-----Original Message-----
From: Trond Myklebust [mailto:trond.myklebust@fys.uio.no]
Sent: Tuesday, September 11, 2001 4:22 PM
To: chen, xiangping
Cc: 'nfs-request@lists.sourceforge.net'; linux-kernel@vger.kernel.org
Subject: Re: Questions on NFS client inode management.


>>>>> " " == xiangping chen <chen> writes:

     > Hi, I have a question on inode management for NFS client.  It
     > seems that the inodes created on a NFS client for a mounted nfs
     > file system stays around until the file being removed. Is there
     > any limits on how many inodes are allowed in memory for NFS? 
     > What kind of behavior we expect if a malicious/careless
     > application just keeps creating new files and flood the kernel
     > memory with inodes created?

The same behaviour as for local files: as memory goes low, the
ordinary reclaiming schemes kick in, and all should be hunky-dory. Of
course in the *real world*, ...

Cheers,
   Trond
