Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262737AbTE0Dww (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 23:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263084AbTE0Dwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 23:52:51 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:18610 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S262737AbTE0Dwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 23:52:50 -0400
Date: Tue, 27 May 2003 01:03:59 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: manish <manish@storadinc.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
In-Reply-To: <3ED2DE86.2070406@storadinc.com>
Message-ID: <Pine.LNX.4.55L.0305270103220.32094@freak.distro.conectiva>
References: <3ED2DE86.2070406@storadinc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 26 May 2003, manish wrote:

> Hello !
>
> I am running the 2.4.20 kernel on a system with 3.5 GB RAM and dual CPU.
> I am running bonnie accross four drives in parallel:
>
> bonnie -s 1000 -d /<dir-name>
>
> bdflush settings on this system:
>
> [root@dyn-10-123-130-235 vm]# cat bdflush
> 2       50      32      100     50      300     1       0       0
>
> All the bonnie process and any other process (like df, ps -ef etc.) are
> hung in __lock_page. Breaking into kdb, I observe the following for one
> such bonnie process:
>
> schedule(..)
> __lock_page(..)
> lock_page(..)
> do_generic_file_read(..)
> generic_file_read(..)
>
> After this, the processes never exit the hang. At times, a couple of
> bonnie processes complete but the hang still occurs with the remaining
> processes and with the other processes.
>
> I tried out the 2.5.33 kernel (one of the 2.5 series) and observed that
> the hang does not occur. If I run, two bonnie processes, they never get
> stuck. Actually, if I run 4 parallel mke2fs, they too get stuck.
>
> Any clues where this could be happening?

Hi,

Are you sure there is no disk activity ?

Run vmstat and check that, please.
