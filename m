Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbWC3NUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWC3NUR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 08:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWC3NUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 08:20:17 -0500
Received: from lucidpixels.com ([66.45.37.187]:30356 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S932203AbWC3NUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 08:20:15 -0500
Date: Thu, 30 Mar 2006 08:19:59 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: linux-kernel@vger.kernel.org
cc: nfs@lists.sourceforge.net
Subject: NFS/Kernel Problem: getfh failed: Operation not permitted
Message-ID: <Pine.LNX.4.64.0603300813270.18696@p34>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The error is: rpc.mountd: getfh failed: Operation not permitted

In order to fix this error, someone needs to run these commands on each 
nfs server.

    40  service nfs stop
    41  rm -f /var/lib/nfs/etab /var/lib/nfs/rmtab /var/lib/nfs/state 
/var/lib/xtab
    42  touch /var/lib/nfs/etab /var/lib/nfs/rmtab /var/lib/nfs/state 
/var/lib/xtab
    43  chmod 644 /var/lib/nfs/etab /var/lib/nfs/rmtab /var/lib/nfs/state 
/var/lib/xtab
    44  service nfs start

http://www.ccs.neu.edu/home/johan/personal/linux.html

This issue seems to be more of an NFS issue than a kernel one, but I was 
wondering what other people had to say about it.  There are a lot of 
responses and questions concerning this error on google, but VERY few 
people have a response or method of fixing it, much less finding a 
permanent fix.

Has anyone found a fix or work-around that does not require restarting 
NFS?

Please CC as I am not on either list.

Thanks,

Justin.
