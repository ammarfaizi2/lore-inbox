Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287183AbSATEQl>; Sat, 19 Jan 2002 23:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287945AbSATEQc>; Sat, 19 Jan 2002 23:16:32 -0500
Received: from aramis.rutgers.edu ([128.6.4.2]:19949 "EHLO aramis.rutgers.edu")
	by vger.kernel.org with ESMTP id <S287183AbSATEQX>;
	Sat, 19 Jan 2002 23:16:23 -0500
Date: Sat, 19 Jan 2002 23:16:22 -0500 (EST)
From: Suresh Gopalakrishnan <gsuresh@cs.rutgers.edu>
To: linux-kernel@vger.kernel.org
Subject: multithreaded RPC handling
In-Reply-To: <Pine.GSO.4.02A.10112151947010.14453-100000@aramis.rutgers.edu>
Message-ID: <Pine.GSO.4.02A.10201192251560.20780-100000@aramis.rutgers.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Am not sure if these are kernel issues or a library issues..

Is it ok to have multiple threads call svc_run() and then let each thread
handle the request it gets? (In other words, does select allow multiple
threads to block on the same set of fds, and correctly wake up only one?)

I was looking at the (old) user level NFS server, and wonder why it forks
multiple servers rather than have threads. Are there any RPC issues
involved? Or is it just to avoid synchronization of the fd/filehandle
caches? (Or maybe the thread support was poor/absent then?)

Thanks
--suresh

