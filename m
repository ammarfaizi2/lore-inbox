Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285213AbRLFVEh>; Thu, 6 Dec 2001 16:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285201AbRLFVEd>; Thu, 6 Dec 2001 16:04:33 -0500
Received: from upb.de ([131.234.22.30]:44221 "EHLO uni-paderborn.de")
	by vger.kernel.org with ESMTP id <S285213AbRLFVBX>;
	Thu, 6 Dec 2001 16:01:23 -0500
Date: Thu, 6 Dec 2001 22:01:02 +0100 (MET)
From: Olaf Bonorden <olaf@bonorden.de>
X-X-Sender: <bono@pferd>
To: <linux-kernel@vger.kernel.org>
Subject: sem uid changes to undefined big number
Message-ID: <Pine.GSO.4.33.0112062136300.956-100000@pferd>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

my program terminates with an EACCES error after a semop call.

cat /proc/sysvipc/sem shows:
  key      semid perms  nsems   uid        gid      cuid  cgid  otime ctime
    0    2555906   114      2 3208641224 134770068   503   100   0  1007646984

503 and 100 are ok, but how can the uid and gid change? The values look
strange, there are no such uids in my system.
The perms were changed too, i set them to 700.

Kernel is 2.4.4, but same on 2.4.15

With 2.2.18 there are no problems.

I cannot descibe what my program does (too long), something with process
migration, but all this is done as normal user - can a user process change
the uid of system resources?

CU
   Olaf


