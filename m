Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317537AbSFEDmL>; Tue, 4 Jun 2002 23:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317539AbSFEDmK>; Tue, 4 Jun 2002 23:42:10 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:59915 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S317537AbSFEDmK>;
	Tue, 4 Jun 2002 23:42:10 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200206050341.g553fvi09850@saturn.cs.uml.edu>
Subject: Re: [rfc] "laptop mode"
To: akpm@zip.com.au (Andrew Morton)
Date: Tue, 4 Jun 2002 23:41:57 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <3CFD453A.B6A43522@zip.com.au> from "Andrew Morton" at Jun 04, 2002 03:54:50 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> Setting this entry to '1' will put the kernel's dirty data writeout
> algorithms into a mode which is better suited to laptop/notebook
> computers.  This mode is specifically designed to minimise the
> frequency of disk spinups.  Laptop mode works as follows:
> 
> - Dirty data remains in memory for longer periods of time (controlled
>   by laptop_writeback_centisecs).
> 
> - If there is pending dirty data and the disk is spun up for any
>   reason (even for a read) then all dirty data will be written back
>   shortly afterwards.  ie: when the disk is spun up, make good use of
>   it.
> 
> - When the decision is made to write back some dirty data, the kernel
>   will write back all dirty data.

Also write out everything just before stopping the disk.
Don't let the disk stop if there is any dirty data.
