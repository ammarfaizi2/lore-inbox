Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129610AbRAKLiF>; Thu, 11 Jan 2001 06:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131437AbRAKLh7>; Thu, 11 Jan 2001 06:37:59 -0500
Received: from pat.uio.no ([129.240.130.16]:48521 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S129610AbRAKLhr>;
	Thu, 11 Jan 2001 06:37:47 -0500
To: Russell King <rmk@arm.linux.org.uk>
Cc: mantel@suse.de (Hubert Mantel), Alan Cox <alan@redhat.com>,
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
Subject: Re: Compatibility issue with 2.2.19pre7
In-Reply-To: <200101100654.f0A6sjJ02453@flint.arm.linux.org.uk>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 11 Jan 2001 12:37:38 +0100
In-Reply-To: Russell King's message of "Wed, 10 Jan 2001 06:54:45 +0000 (GMT)"
Message-ID: <shsy9wi8gl9.fsf@charged.uio.no>
X-Mailer: Gnus v5.6.45/XEmacs 21.1 - "Channel Islands"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Russell King <rmk@arm.linux.org.uk> writes:

     > Hubert Mantel writes:
    >> is this part of 2.2.19pre7 really a good idea? Even in 2.4.0
    >> the size field is still a short.
    >> #define NFS_MAXFHSIZE 64
    >> struct nfs_fh {
    >> - unsigned short size;
    >> + unsigned int size;
    >> unsigned char data[NFS_MAXFHSIZE]; };

     > This is an internal kernel data structure.  Do you know of some
     > program that breaks as a result of this?
     >    _____

Any program which mounts an NFS partition.

If you do this, then you need to provide some sort of compatibility
layer for nfs_mount.h since the format for version 4 of the NFS mount
structure was decided more than 2 years ago.

Cheers,
  Trond
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
