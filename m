Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132651AbRDKQ4B>; Wed, 11 Apr 2001 12:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132653AbRDKQzv>; Wed, 11 Apr 2001 12:55:51 -0400
Received: from columba.EUR.3Com.COM ([161.71.169.13]:3743 "EHLO
	columba.eur.3com.com") by vger.kernel.org with ESMTP
	id <S132651AbRDKQzr>; Wed, 11 Apr 2001 12:55:47 -0400
X-Lotus-FromDomain: 3COM
From: "Jon Burgess" <Jon_Burgess@eur.3com.com>
To: Ben Breuninger <benb@uncontrolled.org>
cc: linux-kernel@vger.kernel.org
Message-ID: <80256A2B.005D1824.00@notesmta.eur.3com.com>
Date: Wed, 11 Apr 2001 17:55:13 +0100
Subject: Re: real-time file monitoring at the kernel level
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



 I have never tried it myself but it looks like it might do what you want:

http://oss.sgi.com/projects/fam/

fam and imon FAQ
===============

What is fam?
fam, the File Alteration Monitor, provides an API which applications can use to
be notified when specific files or directories are changed.

fam comes in two parts: fam, the daemon which listens for requests and delivers
notification, and libfam, a library which client applications can use to
communicate with fam.

If the monitored files are mounted from a remote host, the local fam will
attempt to contact fam on the remote host, and will pass the requests on to the
remote fam.

fam can also notify its clients when a file starts and stops execution. (The
IRIX Interactive Desktop uses this to change a program's icon while it's
running, for example.)

fam was originally written for IRIX in 1989 by Bruce Karsh, and was rewritten in
1995 by Bob Miller. This open-source release of fam builds and runs on both
Linux and IRIX, and is the same fam that will be included with IRIX 6.5.8.

What is imon?
imon, the Inode Monitor, is the part of the kernel that tells fam when files
have changed. When applications tell fam they're interested in files or
directories, fam passes that interest on to imon. When file operations are
performed on files monitored by imon, the kernel tells imon; imon tells fam, and
fam notifies the applications which are interested in the files.

imon was originally written for the IRIX kernel in 1989 by Wiltse Carpenter; the
Linux port was done by Roger Chickering. The Linux implementation in the imon
kernel patch is similar to the IRIX implementation in most ways, but it hooks
into the kernel filesystem code differently.


