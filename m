Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbUKHTPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbUKHTPS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 14:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbUKHTOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 14:14:31 -0500
Received: from alog0232.analogic.com ([208.224.220.247]:7040 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261197AbUKHTMn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 14:12:43 -0500
Date: Mon, 8 Nov 2004 14:10:12 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Arun Srinivas <getarunsri@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: problem with printk--  somebody please help
In-Reply-To: <BAY10-F469WbbjykeNX00014ef5@hotmail.com>
Message-ID: <Pine.LNX.4.61.0411081358510.6407@chaos.analogic.com>
References: <BAY10-F469WbbjykeNX00014ef5@hotmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Nov 2004, Arun Srinivas wrote:

> hi
>
> I am new to the kernel world and would be very glad if somebody could
> help me with this problem.
>
> I am unable to do printk or even a macro call like rdtsc()...(for
> reading the time stamp counter) from within the "activate_task"
> function on a kernel with smp support.But these work under the main
> schedule() function.
>
> I was able to do all these i.e., inside "activate_task" on a kernel
> without smp support.Can anybody suggest a solution as to what could be
> the problem??
>
> somebody please help.
>
> Thanks
> Arun

Maybe it's not called. The task may get put into the run-queue
using resched_task() and __activate_task() as well.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
