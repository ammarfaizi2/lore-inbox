Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277580AbRJRDma>; Wed, 17 Oct 2001 23:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277581AbRJRDmU>; Wed, 17 Oct 2001 23:42:20 -0400
Received: from blount.mail.mindspring.net ([207.69.200.226]:7202 "EHLO
	blount.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S277580AbRJRDmJ>; Wed, 17 Oct 2001 23:42:09 -0400
From: "Steven A. DuChene" <sduchene@mindspring.com>
Date: Wed, 17 Oct 2001 23:42:40 -0400
To: linux-kernel@vger.kernel.org
Cc: nfs@lists.sourceforge.net
Subject: NFS hangs between systems running 2.4.10-ac12 or 2.4.12-ac3
Message-ID: <20011017234240.S2015@lapsony.mydomain.here>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I have noticed the last couple of days that I am getting extremely bad
file transfer (reads) response between systems here I have running various
recent flavors of 2.4.9-ac10, 2.4.10-ac12, and 2.4.12-ac3

The nfs server is running the 2.4.12-ac3 or 2.4.10-ac12. I have tried updating
the nfs-utils on it from the stuff supplied with SuSE-7.1 (0.2.1-17) to the
current 0.3.3 stuff with no change.

The clients are running either mount-2.9z or the more current mount-2.11l.
The client system running 2.9z has a 2.4.9-ac10 kernel and the other with
the 2.11l version of mount is running 2.4.10-ac12

This is most noticeable when I have a directory mounted from the server to the
clients that contains bzipped patch files and when I execute the following on
a client:

bzcat /mnt/net/archive/patch-2.4.12-ac3.bz2 |patch -p1

It just sits there for a LONG time waiting for the transfer to start.
I have tried playing around with various -onfsvers options when I mount
the remote directory but it seems to get worse when I try nfsvers=2 (I have
the above command hung in limbo right now on one of the client systems
where I tried -onfsvers=2

When I compile kernels I turn on the "Provide NFSv3 server support" options.
Also scp'ing the files between the systems proceeds at what seems like a
normal rate.

I have looked in the syslog and dmesg outputs when this occurs but nothing
unusual seems to be getting logged.
-- 
Steven A. DuChene	sad@ale.org
			linux-clusters@mindspring.com
			sduchene@mindspring.com

	http://www.mindspring.com/~sduchene/
