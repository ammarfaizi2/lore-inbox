Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313189AbSDDPRl>; Thu, 4 Apr 2002 10:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313190AbSDDPRb>; Thu, 4 Apr 2002 10:17:31 -0500
Received: from anchor.engin.umich.edu ([141.213.40.34]:36613 "EHLO
	anchor.engin.umich.edu") by vger.kernel.org with ESMTP
	id <S313189AbSDDPRM>; Thu, 4 Apr 2002 10:17:12 -0500
Date: Thu, 4 Apr 2002 10:17:06 -0500 (EST)
From: Christopher Allen Wing <wingc@engin.umich.edu>
To: <mharris@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Process Accounting 32bit UID/GID support
Message-ID: <Pine.LNX.4.33.0204041011520.23808-100000@anchor.engin.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike:

Are you sure you want to do this:

-	char		ac_pad[10];		/* Accounting Padding Bytes */
+	__u32		ac_uid32;		/* Accounting Real 32bit User ID */
+	__u32		ac_gid32;		/* Accounting Real 32bit Group ID */
+	char		ac_pad[2];		/* Accounting Padding Bytes */



This changes the size of the accounting structure because the new fields
are padded to 4 byte alignment.

Support for process accounting was part of my original patches for 32 bit
UIDs, but it never got picked up. I think that at the time there was an
expectation that accounting was going to be replaced entirely with new
code (SGI accounting stuff?)


Here's an updated version of my patch:

	http://www.engin.umich.edu/caen/systems/Linux/code/misc/acct/linux-2.4.17-acct-uid32.patch


Thanks,

Chris Wing
wingc@engin.umich.edu

