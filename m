Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280942AbRKLTgo>; Mon, 12 Nov 2001 14:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280944AbRKLTgf>; Mon, 12 Nov 2001 14:36:35 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:26386 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S280942AbRKLTg3>; Mon, 12 Nov 2001 14:36:29 -0500
Date: Mon, 12 Nov 2001 16:18:12 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: "Gord R. Lamb" <glamb@max-t.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: I/O lockup
In-Reply-To: <Pine.LNX.4.32.0111121248360.4885-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0111121617150.1064-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 12 Nov 2001, Gord R. Lamb wrote:

> Hi everyone,
> 
> I've been having a problem for a while now with a strange lockup induced
> under heavy SCSI I/O (particularly when I write directly to block devices
> with dd of=/dev/sd?, but also when writing to a filesystem on that
> device).  I'm writing around 50-100mb/sec over FC (qlogic 2200) under
> Linux 2.4 (tried 2.4.3 through 2.4.10).
> 
> It seems that some vm or I/O related spinlock is being taken and held, but
> not released (?).  There is no oops or BUG() or anything (no messages at
> all in fact).. all I/O just stops.  I can still invoke sysrq, type
> characters at the console, etc.  In fact, usually top continues to run and
> display kswapd as the dominant process.

If kswapd is eating the CPU, its probably a VM problem.

Please try the newest 2.4.xx which has VM updates and if the problem
happens again, tell us.



