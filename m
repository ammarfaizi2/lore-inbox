Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262986AbTC1OMO>; Fri, 28 Mar 2003 09:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262987AbTC1OMN>; Fri, 28 Mar 2003 09:12:13 -0500
Received: from uni02du.unity.ncsu.edu ([152.1.13.102]:19843 "EHLO
	uni02du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id <S262986AbTC1OMN>; Fri, 28 Mar 2003 09:12:13 -0500
From: jlnance@unity.ncsu.edu
Date: Fri, 28 Mar 2003 09:23:28 -0500
To: linux-kernel@vger.kernel.org
Subject: sendfile or r+w for sending file to multiple machines
Message-ID: <20030328142328.GA5242@ncsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,
    I have an application that needs to be able to send large files to
multiple machines (less than 10).  The files get sent to the machines at
the same time so we are thinking about writing the code so that it does
1 read (or perhaps a mmap) on the file, and then does multiple writes,
onece to each machines socket.
    We are also considering using multicast but this seems unnecessarily
complex.  I dont want to reimplement TCP.
    We could also write this using sendfile, and I dont know if that
is a good idea or not (hence this post).  I think I would have to start
multiple threads to get sendfile to work.  This makes things more
complex which is a minus, but how about performance.  Do you think
this would work better than read+write?  The files are larger than
system memory so our goal is to avoid reading the multiple times.
With sendfile we can not really control how the files get read, but
it seems likely that the different threads would inherently synchronize
themselves.  Any thoughts?

Thanks,

Jim
