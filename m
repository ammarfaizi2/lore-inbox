Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269237AbRHQOjN>; Fri, 17 Aug 2001 10:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269350AbRHQOjD>; Fri, 17 Aug 2001 10:39:03 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:61831 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S269237AbRHQOiy>;
	Fri, 17 Aug 2001 10:38:54 -0400
Date: Fri, 17 Aug 2001 09:39:02 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Mark Hahn <hahn@physics.mcmaster.ca>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] processes with shared vm
Message-ID: <43080000.998059142@baldur>
In-Reply-To: <Pine.LNX.4.10.10108171428450.21522-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.10.10108171428450.21522-100000@coffee.psychology.mcm
 aster.ca>
X-Mailer: Mulberry/2.1.0b3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Friday, August 17, 2001 14:30:28 +0000 Mark Hahn 
<hahn@physics.mcmaster.ca> wrote:

> from a quick glance, there is no tgid, and deliberately so:
> proc.thread_group is a list of siblings, no?  siblings that
> normally share their struct mm.

There is in fact a tgid in the task_struct.  Its value is the pid of the 
task that first called clone() with CLONE_THREAD set.  And in fact the 
getpid() system call actually returns tgid instead of pid.  It seems to me 
only reasonable to include this in the information available via /proc.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

