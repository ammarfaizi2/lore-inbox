Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317424AbSHHKDj>; Thu, 8 Aug 2002 06:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317429AbSHHKDj>; Thu, 8 Aug 2002 06:03:39 -0400
Received: from dclient217-162-176-39.hispeed.ch ([217.162.176.39]:18707 "EHLO
	alder.intra.bruli.net") by vger.kernel.org with ESMTP
	id <S317424AbSHHKDi>; Thu, 8 Aug 2002 06:03:38 -0400
From: "Martin Brulisauer" <martin@bruli.net>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Date: Thu, 8 Aug 2002 12:07:15 +0200
Subject: RE: O_SYNC option doesn't work (2.4.18-3)
Reply-to: martin@bruli.net
CC: "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Message-ID: <3D525EF3.23894.928E229@localhost>
In-reply-to: <200208072048.PAA04274@tomcat.admin.navo.hpc.mil>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Aug 2002, at 15:48, Jesse Pollard wrote:

> 
> There never was any such thing as "cache coherency" in NFS. And there won't
> be - the overhead is way too high. Think- to lock a section of a file,
> you first tell the local daemon. That local daemon must then contact the
> remote file server. That file server must then contact EVERY client to verify
> that a lock is not in the process of being established. And confirm that the
> locked section just hasn't yet been flushed back to the server. Then the server
> can tell the client the section is locked.
>
On VMS we call it "Distributed Lock Manager". The overhead is not 
so high and it works well. 
> 
> What happens when one of the clients is down....
> How long do you wait to determine a client is down...
> What happens to other clients while the client holding the lock is down...
> What happens when the server goes down....
> What happens when the down client comes back up....
> What happens when the server comes back up....
> How do you request all clients to re-acquire locks... (and in what order)
> 

To solve this problem you need the cluster votes/quorum technique.

> And remember... NFS is a stateless protocol. No additional information about

The only way to do it is the implementation of a real linux cluster 
with it's distributed and shared disk access. NFS can never be a 
replacement for a clusterd disk access.

Martin Brulisauer

