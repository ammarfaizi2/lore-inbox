Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261719AbULJHjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbULJHjR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 02:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbULJHjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 02:39:17 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:50921 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261719AbULJHjP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 02:39:15 -0500
Date: Fri, 10 Dec 2004 08:39:14 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] jobfs - new virtual filesystem for job kernel/user
In-Reply-To: <200412091724.iB9HOEf26056@dbear.engr.sgi.com>
Message-ID: <Pine.LNX.4.53.0412100837050.27203@yvahk01.tjqt.qr>
References: <200412091724.iB9HOEf26056@dbear.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>I maintain my position that this belongs in /proc.
>This is a question I try to find an answer. If the community agrees
>the /proc is the right place for it, I would be very happy to move it
>to /proc and implement it with procfs.
>>>Why not have a structure something like:
>>>/proc/<pid>/job -> ../jobs/<jid>
>But adding /proc/<pid>/job needs to patch fs/proc/base.c, we can not
>do that in a module. Of course if job gets accepted, this won't be a problem.

That depends on whether the community (read: the standard user) needs it. Maybe
we could make some procfs functions exported and let jobfs be dependent on
procfs (let jobfs using proc_create_dir() for example).

Jan Engelhardt
-- 
ENOSPC
