Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264509AbTDYVIw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 17:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264514AbTDYVIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 17:08:52 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8463 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264509AbTDYVIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 17:08:49 -0400
Message-ID: <3EA9A6AF.7060409@zytor.com>
Date: Fri, 25 Apr 2003 14:20:47 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, sv
MIME-Version: 1.0
To: davidm@hpl.hp.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 vsyscall DSO implementation
References: <3EA8942D.4050201@pobox.com>	<200304250210.h3P2AoU12348@magilla.sf.frob.com>	<16041.24730.267207.671647@napali.hpl.hp.com>	<b8c7m5$u3u$1@cesium.transmeta.com> <16041.42469.529671.272810@napali.hpl.hp.com>
In-Reply-To: <16041.42469.529671.272810@napali.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger wrote:
> 
>   >> To complete the picture, it would be nice if the kernel ELF
>   >> images were mappable files (either in /sysfs or /proc) and would
>   >> show up in /proc/PID/maps.  That way, a distributed application
>   >> such as a remote debugger could gain access to the kernel unwind
>   >> tables on a remote machine (assuming you have a remote
>   >> filesystem).
> 
>   hpa> How about /boot?
> 
> You mean a regular file?  I'm not sure whether this could be made to
> work.  The /proc/PID/maps entry (really: the vm_area for the kernel
> ELF images) would have to be created by the kernel, at a time when no
> real filesystem is available.  Also, since the kernel needs to store
> the data in kernel-memory anyhow, I don't think there is much point in
> storing it on disk as well.
> 

Perhaps I misunderstood the statement.  With "kernel ELF images" above,
I am now gathering you're talking about only the segments exported to
userspace (i.e. vsyscall code), not the kernel itself, which was my
original reading of that statement.

	-hpa

