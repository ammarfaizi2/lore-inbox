Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263678AbTDGWFf (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 18:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263690AbTDGWFf (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 18:05:35 -0400
Received: from [12.47.58.221] ([12.47.58.221]:19527 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263678AbTDGWFe (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 18:05:34 -0400
Date: Mon, 7 Apr 2003 14:15:51 -0700
From: Andrew Morton <akpm@digeo.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: More Testing with 4000 disks
Message-Id: <20030407141551.5900e44f.akpm@digeo.com>
In-Reply-To: <200304071454.49849.pbadari@us.ibm.com>
References: <200304071454.49849.pbadari@us.ibm.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Apr 2003 22:17:04.0098 (UTC) FILETIME=[6B1D2420:01C2FD53]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> Hi,
> 
> Here is more on testing with simulated 4000 disks.
> 
> I mounted 4000 simulated (scsi_debug) disks. But
> when I tried to do IO on 200 of them (just reads),
> system is 100% busy. Here are the vmstat,
> 10-sec profile output and sysrq-t output.
> 
> I am wondering why 100% sys ?
> 

This doesn't make sense.  You're showing 50% CPU time in schedule(), yet the
(undescribed) machine is doing only 11k context switches/sec.

How come?

What context switch rate and profile were you getting when performing IO against a
large number of real disks?

