Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S156683AbPLSRmU>; Sun, 19 Dec 1999 12:42:20 -0500
Received: by vger.rutgers.edu id <S156550AbPLSRl7>; Sun, 19 Dec 1999 12:41:59 -0500
Received: from va-su-140.valinux.com ([209.81.8.140]:2161 "EHLO mail.valinux.com") by vger.rutgers.edu with ESMTP id <S156622AbPLSRlv>; Sun, 19 Dec 1999 12:41:51 -0500
Date: Sun, 19 Dec 1999 09:41:36 -0800
From: "H . J . Lu" <hjl@valinux.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: nfs@mail1.sourceforge.net, linux kernel <linux-kernel@vger.rutgers.edu>, alan@lxorguk.ukuu.org.uk
Subject: nfs-utils 0.1.5 is released.
Message-ID: <19991219094136.A4016@valinux.com>
References: <199912190029.AAA08880@raistlin.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <199912190029.AAA08880@raistlin.arm.linux.org.uk>
Sender: owner-linux-kernel@vger.rutgers.edu

On Sun, Dec 19, 1999 at 12:29:27AM +0000, Russell King wrote:
> Hi hjl,
> 
> I'm sure this is a FAQ, but where can I find knfsd-1.4.7.tar.gz (which
> is referenced in Alan's 2.2.14pre15 patch)?

The knfsd tar file has been replaced by nfs-utils.


-- 
H.J. Lu (hjl@gnu.org)
--
This is the Linux NFS utility package version 0.1.5. It is based on
knfsd 1.4.7.

WARNING: The NFS servers in Linux 2.2 to 2.2.13 are not compatible with
other NFS client implemenations. If you plan to use Linux 2.2.x as an
NFS server for non-Linux NFS clients, you should get the Linux NFS
kernel from the Linux NFS CVS server:

1. Set the environment variable, CVS_RSH, to ssh.
2. Login to the Linux NFS CVS server:

# cvs -z 3 -d:pserver:anonymous@cvs.linuxnfs.sourceforge.org:/cvsroot/nfs login

without password if it is your first time.

3. Check out the current Linux 2.2 NFS kernel:

a. From the NFS V2 branch:

# cvs -z 3 -d:pserver:anonymous@cvs.linuxnfs.sourceforge.org:/cvsroot/nfs co -r linux-2-2-nfsv2 linux-2.2

b. From the main trunk:

# cvs -z 3 -d:pserver:anonymous@cvs.linuxnfs.sourceforge.org:/cvsroot/nfs co linux-2.2

4. If you don't want to use the current NFS kernel, you can find out
for which kernels the NFS patch is available:

# cd linux-2.2
# cvs -z 9 -d:pserver:anonymous@cvs.linuxnfs.sourceforge.org:/cvsroot/nfs status -v Makefile

Then generate the kernel patch:

# cvs -z 3 -d:pserver:anonymous@cvs.linuxnfs.sourceforge.org:/cvsroot/nfs rdiff -ko -u -r linux-2-2-xx -r linux-2-2-xx-nfsv2-xxxxx linux-2.2

If there is no NFS patch for the kernel you are interested in, you have
to make a patch closest to your kernel version and apply it by hand.

There is a Linux NFS kernel source tree for Linux 2.3, linux-2.3, on
the Linux NFS CVS server. We will need all the help we can get. To
contribute to the Linux NFS project, please go to

http://www.linuxnfs.sourceforge.org

You register yourself. Please send an email to
nfs-admin@linuxnfs.sourceforge.org with

1. Your user id on www.linuxnfs.sourceforge.org.
2. The area in NFS you'd like to work on.

You will be notified when it is done.

There is a Linux NFS mailing list at

http://lists.sourceforge.net/mailman/listinfo/nfs/                                                               
You can subscribe it and search the mailing list archive via a web
browser.

The nfs-utils package is available from the CVS server:

# cvs -z 3 -d:pserver:anonymous@cvs.linuxnfs.sourceforge.org:/cvsroot/nfs co nfs-utils

will get the latest version.

The files are

ftp://ftp.linuxnfs.sourceforge.org/pub/nfs/nfs-utils-0.1.5.tar.gz
ftp://ftp.linuxnfs.sourceforge.org/pub/nfs/nfs-utils-0.1.4-0.1.5.diff.gz

To compile, just do

# ./configure
# make

# make install

will install the nfs-utils binaries. You have to install the NFS
service scripts. There are 2 in etc/redhat provided for RedHat 6.x.
They are tested on RedHat 6.1.

On RedHat 6.1, you can use

# rpm -ta nfs-utils-0.1.5.tar.gz

to build the source and binary RPMs.

If your mount from util-linux is too old, you will need 2 patches:

ftp://ftp.linuxnfs.sourceforge.org/pub/nfs/util-linux-2.9o-mount-nfsv3.patch
ftp://ftp.linuxnfs.sourceforge.org/pub/nfs/util-linux-2.9w-mount-nfsv3try.patch

Thanks.


H.J.
hjl@lucon.org
12/19/99

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
