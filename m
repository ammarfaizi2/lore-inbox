Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262812AbTARGt5>; Sat, 18 Jan 2003 01:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262821AbTARGt5>; Sat, 18 Jan 2003 01:49:57 -0500
Received: from packet.digeo.com ([12.110.80.53]:2441 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262812AbTARGt4>;
	Sat, 18 Jan 2003 01:49:56 -0500
Date: Fri, 17 Jan 2003 23:00:14 -0800
From: Andrew Morton <akpm@digeo.com>
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: recent change to exit_mmap
Message-Id: <20030117230014.2647791a.akpm@digeo.com>
In-Reply-To: <20030118060522.GE7800@krispykreme>
References: <20030118060522.GE7800@krispykreme>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Jan 2003 06:58:50.0041 (UTC) FILETIME=[0DDCF290:01C2BEBF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard <anton@samba.org> wrote:
>
> It seems with the TIF_32BIT scheme we have a window between
> SET_PERSONALITY until exec returns where TASK_SIZE might be considered
> incorrect (although at which exact point to you decide that, yes we are
> now in the new context).
> 
> Any ideas on how to fix this? Maybe we can move SET_PERSONALITY down
> after flush_old_exec.
> 

On seconds thoughts...

Are the first two SET_PERSONALITY() calls in there actually doing anything? 
Perhaps you're right, and we only need the one at line 615, whcih is in the
right place?

