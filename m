Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261874AbSKMPDb>; Wed, 13 Nov 2002 10:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261894AbSKMPDb>; Wed, 13 Nov 2002 10:03:31 -0500
Received: from leon.mat.uni.torun.pl ([158.75.2.17]:44237 "EHLO
	Leon.mat.uni.torun.pl") by vger.kernel.org with ESMTP
	id <S261874AbSKMPDa>; Wed, 13 Nov 2002 10:03:30 -0500
Date: Wed, 13 Nov 2002 16:10:01 +0100 (CET)
From: Michal Wronski <wrona@mat.uni.torun.pl>
X-X-Sender: wrona@Leon
To: linux-kernel@vger.kernel.org
cc: Peter Waechtler <pwaechtler@mac.com>,
       Krzysztof Benedyczak <golbi@mat.uni.torun.pl>,
       "Gustafson, Geoffrey R" <geoffrey.r.gustafson@intel.com>,
       "Abbas, Mohamed" <mohamed.abbas@intel.com>
Subject: Re: [PATCH] unified SysV and POSIX mqueues - complete rewrite
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C70992@orsmsx119.jf.intel.com>
Message-ID: <Pine.LNX.4.44.0211131555530.9870-100000@Leon>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The interface boils down to 7 new syscalls (for now just i386):
> - sys_mq_open
> - sys_mq_unlink
> - sys_mq_timedsend
> - sys_mq_timedreceive
> ...

Why add a new syscalls?? It's better to do this via ioctl's

> The change to ipc/msg.c is minimal - just make
> - load_msg
> - store_msg
> - free_msg
> accessible (not static).

I suggest doing this independently to SysV IPC

> userspace lib and test progs are on
> http://homepage.mac.com/pwaechtler/linux/mqueue/

"We're sorry, but we can't find the HomePage you've requested."

> +#ifndef _LINUX_MQUEUE_H
> +#define _LINUX_MQUEUE_H
> +
> +#define MQ_MAXMSG 40 /* max number of messages in each queue */
> +#define MQ_MAXSYSSIZE 1048576 /* max size that all m.q. can have 
> together 
> */
> +#define MQ_PRIO_MAX 10000 /* max priority */

I see that you've read our sources....

We (K. Benedyczak with me) are currently working on new implementation of 
mqueues. It's very similar to yours (filesystem, without new syscalls) and 
it's almost done. Maybe we should collaborate??

Michal Wronski

