Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314078AbSHBX0s>; Fri, 2 Aug 2002 19:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316933AbSHBX0r>; Fri, 2 Aug 2002 19:26:47 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:62980 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S314078AbSHBX0r>; Fri, 2 Aug 2002 19:26:47 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Paul Menage <pmenage@ensim.com>
To: Ryan Anderson <ryan@michonline.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: manipulating sigmask from filesystems and drivers 
cc: pmenage@ensim.com
In-reply-to: Your message of "Fri, 02 Aug 2002 19:25:01 EDT."
             <Pine.LNX.4.10.10208021920210.579-100000@mythical.michonline.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 02 Aug 2002 16:30:12 -0700
Message-Id: <E17als4-00048R-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> How about a sysctl that lets the user specify the size threshold at
>> which writes use a killable wait state rather than
>> TASK_UNINTERRUPTIBLE? (Probably defaulting to never.)
>
>/usr/include/linux/limits.h:#define PIPE_BUF        4096        /* #
>bytes in atomic write to a pipe */
>
>According to SUSv3, this is the maximum size that write is guaranteed to
>be atomic for.

But that doesn't mean that we can't allow the user to configure higher
limits if they're using some particular software that relies on (and
more importantly, has successfully relied upon in the past) the current 
behaviour of no interruptions.

Paul



