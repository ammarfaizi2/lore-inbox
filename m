Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262763AbTENUQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 16:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbTENUQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 16:16:28 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:15499 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262763AbTENUQ0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 16:16:26 -0400
Date: Wed, 14 May 2003 13:24:40 -0700
From: Andrew Morton <akpm@digeo.com>
To: Philippe =?ISO-8859-1?Q?Gramoull=E9?= 
	<philippe.gramoulle@mmania.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.68-mm2: Memory & swap issues ?
Message-Id: <20030514132440.0df9b2f5.akpm@digeo.com>
In-Reply-To: <20030514133848.74b8736f.philippe.gramoulle@mmania.com>
References: <20030514133848.74b8736f.philippe.gramoulle@mmania.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-OriginalArrivalTime: 14 May 2003 20:29:09.0985 (UTC) FILETIME=[7986A510:01C31A57]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philippe Gramoullé  <philippe.gramoulle@mmania.com> wrote:
>
> MemTotal:       514452 kB
> MemFree:         20720 kB
> Buffers:          8200 kB
> Cached:          74148 kB
> SwapCached:      38488 kB
> Active:         412740 kB
> Inactive:        12824 kB
> HighTotal:           0 kB
> HighFree:            0 kB
> LowTotal:       514452 kB
> LowFree:         20720 kB
> SwapTotal:      618460 kB
> SwapFree:        15156 kB
> Dirty:            7228 kB
> Writeback:           0 kB
> Mapped:         337808 kB
> Slab:            57520 kB
> Committed_AS:  1023568 kB
> PageTables:       2804 kB
> VmallocTotal:   516040 kB
> VmallocUsed:      3308 kB
> VmallocChunk:   512688 kB

Are you sure you don't have some big leaky application which is swapped
out?

Check `top', `ps aux', etc, see if something has a big virtual size.

Restart the X server.

See if swapoff -a invokes the oom-killer ;)

Failing all that, it might be a swapspace accounting error.


