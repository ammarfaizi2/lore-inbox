Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317419AbSGTPCs>; Sat, 20 Jul 2002 11:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317422AbSGTPCs>; Sat, 20 Jul 2002 11:02:48 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:779 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317419AbSGTPCr>; Sat, 20 Jul 2002 11:02:47 -0400
Date: Sat, 20 Jul 2002 12:05:40 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel@vger.kernel.org
Subject: oops in follow_mount
Message-ID: <Pine.LNX.4.44L.0207201202561.12241-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've gotten an oops in follow_mount with today's 2.5.26-bk:

Unable to handle kernel NULL pointer dereference at virtual address 00000054
....

The function call trace is:

syscall+7 -> sys_stat64+18 -> vfs_stat+25 -> __user_walk+40 ->
path_lookup+230 -> link_path_walk+1342 -> follow_mount+30

The oops happened while trying to compile a kernel over NFS.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

