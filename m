Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131627AbRCXKUy>; Sat, 24 Mar 2001 05:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131630AbRCXKUo>; Sat, 24 Mar 2001 05:20:44 -0500
Received: from hera.cwi.nl ([192.16.191.8]:6843 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S131627AbRCXKUc>;
	Sat, 24 Mar 2001 05:20:32 -0500
Date: Sat, 24 Mar 2001 11:18:48 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200103241018.LAA07342.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, paul@jakma.org
Subject: Re: [PATCH] Prevent OOM from killing init
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From paul@jakma.org Sat Mar 24 03:00:17 2001

    > No, ulimit does not work. (But it helps a little.)

    no, not perfect, i very much agree. but in daily usage it reduces
    chance of OOM to close to 0.

No. How would you use it? Compute individual limits for
each process? One typically has a few very large processes
that may easily take most of memory, and lots of small processes.
With a low ulimit these large processes do not run.
With a large ulimit it does not help against OOM.
The job of accounting what is available belongs to the system,
not the user.

Note that ulimit does not limit the sum of your processes,
it limits each individual process.

Andries
