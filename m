Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbTDHWSs (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 18:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbTDHWSs (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 18:18:48 -0400
Received: from [12.47.58.221] ([12.47.58.221]:43490 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262134AbTDHWSo (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 18:18:44 -0400
Date: Tue, 8 Apr 2003 14:28:53 -0700
From: Andrew Morton <akpm@digeo.com>
To: Alistair Strachan <alistair@devzero.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.67-mm1
Message-Id: <20030408142853.74709a82.akpm@digeo.com>
In-Reply-To: <200304081741.10129.alistair@devzero.co.uk>
References: <200304081741.10129.alistair@devzero.co.uk>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Apr 2003 22:30:15.0852 (UTC) FILETIME=[6D72F6C0:01C2FE1E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair Strachan <alistair@devzero.co.uk> wrote:
>
> On attempting to boot this kernel, I get the following just before init:
> Kernel panic: VFS: Unable to mount root fs on 03:05
> 
> 2.5.67 base works fine. I discovered that reverting the following 
> patches allows me to boot. I can increase the granularity of my search 
> if nothing comes immediately to mind:
> 
> aggregated-disk-stats.patch
> dynamic-hd_struct-allocation-fixes.patch
> dynamic-hd_struct-allocation.patch
> 

Ah, good detective work, thanks.  It looks like the hd_struct dynamic allocation
patch has broken devfs partition discovery somehow.

