Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264806AbSKJK6r>; Sun, 10 Nov 2002 05:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264807AbSKJK6r>; Sun, 10 Nov 2002 05:58:47 -0500
Received: from [196.12.44.6] ([196.12.44.6]:53902 "EHLO gdit.iiit.net")
	by vger.kernel.org with ESMTP id <S264806AbSKJK6q>;
	Sun, 10 Nov 2002 05:58:46 -0500
Date: Sun, 10 Nov 2002 16:34:10 +0530 (IST)
From: Prasad <prasad_s@gdit.iiit.net>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Distributed Linux
Message-ID: <Pine.LNX.4.44.0211061650410.26508-100000@gdit.iiit.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,
	the subject may be too ambitious, but thats not a prank i am 
playing... As a graduation project i intended to make linux distributed... 
by distributed i mean, enabling process migration, selecting eligible 
nodes, and ofcourse selecting candidate processes which would be migrated 
to the selected node.  The following is the description of how i intended 
to do and would like inputs/suggessions from the gurus here.

The processes would be dynamically migrated from one node to the other
based on the selections of local process (candidate) and the remote node.  
The entire task along with its memory map will be migrated on to the other
system (This system however would be later changed to migrate only
referenced pages).  The guest system (where the process originated) would
however have a pseudo process running on it, which would not take much
resources but would help in handling various signals/interrupts and in
handling system calls.  This method of handling helps is in migrating the
user mode execution (which is on an average greater than 75%) to some
other system on the network thus reducing the load on the guest system.

As of now i am trying to device a migration system where the system mode 
computation is mostly carried out on the tasks original system, as this 
simplifies the implementation and helps maintaining the speed and 
efficiency in cases where the distribution is not needed.

Prasad

-- 
Failure is not an option


