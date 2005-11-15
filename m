Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965055AbVKOWoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965055AbVKOWoA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 17:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbVKOWn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 17:43:59 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:54931 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S965055AbVKOWn7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 17:43:59 -0500
Date: Tue, 15 Nov 2005 14:43:19 -0800
From: Paul Jackson <pj@sgi.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: raybry@mpdtxmail.amd.com, serue@us.ibm.com, linux-kernel@vger.kernel.org,
       frankeh@watson.ibm.com, haveblue@us.ibm.com
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
Message-Id: <20051115144319.2100c47e.pj@sgi.com>
In-Reply-To: <20051115210504.GE17287@sergelap.austin.ibm.com>
References: <20051114212341.724084000@sergelap>
	<200511151321.08860.raybry@mpdtxmail.amd.com>
	<20051115194127.GB17287@sergelap.austin.ibm.com>
	<200511151430.35504.raybry@mpdtxmail.amd.com>
	<20051115210504.GE17287@sergelap.austin.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This has been demonstrated to be not true.  Again, see ckpt for a simple
> example.
> 
> Oh, right, well willingness to run inside of a container *is* something we
> would require :)  Not needed for checkpointing a single process,
> however - see ckpt.

Be careful not to assume that some set of requirements on our result
is an appropriate set because, for each requirement, someone else has
demonstrated a solution that meets that requirement.

Sometimes there are tradeoffs.  For example, ckpt will checkpoint/restart
a single task without kernel support, but doesn't preserve (from its README
at http://www.cs.wisc.edu/~zandy/ckpt/README):

- File descriptors of open files, special devices,
  pipes, and sockets;
- Interprocess communication state (such as shared memory, semaphores,
  mutex, messages);
- Kernel-level thread state;
- Process identifiers, including process id, process group;
  id, user id, or group id.

and doesn't work with static bound programs (uses PRELOAD).

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
