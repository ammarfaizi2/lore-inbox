Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263159AbUD2Dyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263159AbUD2Dyo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 23:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263166AbUD2Dyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 23:54:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:50911 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263159AbUD2Dym (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 23:54:42 -0400
Date: Wed, 28 Apr 2004 20:54:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: busterbcook@yahoo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: pdflush eating a lot of CPU on heavy NFS I/O
Message-Id: <20040428205423.19bc7685.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0404281534110.3044@ozma.hauschen>
References: <Pine.LNX.4.58.0404280009300.28371@ozma.hauschen>
	<20040427230203.1e4693ac.akpm@osdl.org>
	<Pine.LNX.4.58.0404280826070.31093@ozma.hauschen>
	<20040428124809.418e005d.akpm@osdl.org>
	<Pine.LNX.4.58.0404281534110.3044@ozma.hauschen>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brent Cook <busterbcook@yahoo.com> wrote:
>
> Here are memory stats for the same machine. The other machine's stats
>  are similar; there doesn't appear to be anything out of the ordinary and
>  its not even touching swap if these numbers are to be believed.
> 
>  busterb@snowball2:~$ cat /proc/meminfo
>  MemTotal:       256992 kB
>  MemFree:        139700 kB
>  Buffers:         36464 kB
>  Cached:          61516 kB
>  SwapCached:          0 kB
>  Active:          50536 kB
>  Inactive:        51672 kB
>  HighTotal:           0 kB
>  HighFree:            0 kB
>  LowTotal:       256992 kB
>  LowFree:        139700 kB
>  SwapTotal:      514040 kB
>  SwapFree:       514040 kB
>  Dirty:            1876 kB
>  Writeback:           0 kB
>  Mapped:           8552 kB
>  Slab:            10924 kB
>  Committed_AS:    14612 kB
>  PageTables:        356 kB
>  VmallocTotal:   778164 kB
>  VmallocUsed:      2936 kB
>  VmallocChunk:   774708 kB

Was this captured while pdflush was misbehaving?
