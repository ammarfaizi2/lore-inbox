Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130660AbRCPQbc>; Fri, 16 Mar 2001 11:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130656AbRCPQbW>; Fri, 16 Mar 2001 11:31:22 -0500
Received: from mxic1.isus.emc.com ([168.159.211.82]:16143 "EHLO
	mxic1.isus.emc.com") by vger.kernel.org with ESMTP
	id <S130617AbRCPQbK>; Fri, 16 Mar 2001 11:31:10 -0500
Message-ID: <93F527C91A6ED411AFE10050040665D0560664@corpusmx1.us.dg.com>
From: Sane_Purushottam@emc.com
To: linux-kernel@vger.kernel.org
Subject: fork and pthreads
Date: Fri, 16 Mar 2001 11:34:04 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having a strange problem.

I have a big daemon program to which I am trying to add multi-threading.

At the begining, after some sanity check, this program does a double fork to
create a deamon.

After that it listens for the client on the port. Whenever the client
connects, it creates a new thread using
pthread-create.

The problem is, the thread (main thread) calling pthread-create hangs
indefinetely in __sigsuspend. The newly created thread however, runs
normally to completion.

I wrote few test programs trying to simulate this behaviour but all of them
worked as expected.

Does anyone know, what's going on ??

Nitin Sane
sane_purushottam@emc.com
*(508)382-7319

