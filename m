Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282133AbRLLVC2>; Wed, 12 Dec 2001 16:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282178AbRLLVCS>; Wed, 12 Dec 2001 16:02:18 -0500
Received: from pat.uio.no ([129.240.130.16]:20621 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S282133AbRLLVCN>;
	Wed, 12 Dec 2001 16:02:13 -0500
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS woes in 2.5.1-pre8
In-Reply-To: <20011212164334.B16377@flint.arm.linux.org.uk>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 12 Dec 2001 22:02:01 +0100
In-Reply-To: <20011212164334.B16377@flint.arm.linux.org.uk>
Message-ID: <shsofl49mpi.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Russell King <rmk@arm.linux.org.uk> writes:

     > I'm not sure if this is expected or not, but I'm seeing odd
     > behaviour with NFS on 2.5.1-pre8:

     > [root@assabet bin]$vdir ../lib -rwxr-xr-x 1 51 51 29091 Dec 12
     > 2001 libts-0.0.so.0.0.0 ../lib: Input/output error
<snip>
     > Admittedly raistlin is running a rather old, obsolete NFS
     > server, which has up until now worked faultlessly for around 2
     > years: Universal NFS Server 2.2beta48

     > Appologies, but I'm not sure how I got it into this state
     > either - last thing I had done was to overwrite the files in
     > ../lib and bin with new sets on the NFS server.  The only
     > directory that is suffering is ../lib.  (there's bin and
     > ../include as well, both of which would've had their files
     > overwritten with later versions).

There are (as of yet) no changes to the NFS client in 2.5.x.

Do you have any idea which syscall the above EIO is coming from? From
your tcpdump, it didn't appear to be coming from the server, and the
file attributes are getting displayed...

Cheers,
   Trond
