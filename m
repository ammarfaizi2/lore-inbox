Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316599AbSFPWGM>; Sun, 16 Jun 2002 18:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316600AbSFPWGL>; Sun, 16 Jun 2002 18:06:11 -0400
Received: from hera.cwi.nl ([192.16.191.8]:38122 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S316599AbSFPWGL>;
	Sun, 16 Jun 2002 18:06:11 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 17 Jun 2002 00:05:40 +0200 (MEST)
Message-Id: <UTC200206162205.g5GM5eJ05123.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, viro@math.psu.edu
Subject: Re: [CHECKER] 37 stack variables >= 1K in 2.4.17
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The result of Step One is that the loop no longer touches all
>> filesystems but lives entirely in namei.c. So, the second patch,
>> that only changes namei.c can change the recursion into iteration.
>> Maybe tomorrow or the day after.

> Obvious breakage: nd->flags can be clobbered by __vfs_follow_link(),
> so your do_follow_link() and friends are broken.

Yes, I know. No doubt you are able to fix that by reading that bit
before calling __vfs_follow_link(). It will be repaired fully
automatically tomorrow or the day after when __vfs_follow_link()
disappears altogether.

But that is the microscopic criticism. I was more interested in
hearing comments on the global setup.

Andries
