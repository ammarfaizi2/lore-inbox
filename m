Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282947AbRLQWUQ>; Mon, 17 Dec 2001 17:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282959AbRLQWUC>; Mon, 17 Dec 2001 17:20:02 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:61702 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S282919AbRLQWTh> convert rfc822-to-8bit; Mon, 17 Dec 2001 17:19:37 -0500
Date: Mon, 17 Dec 2001 19:04:52 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: David Gomez <davidge@jazzfree.com>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Loopback deadlock again
In-Reply-To: <Pine.LNX.4.33.0112172246400.558-100000@fargo>
Message-ID: <Pine.LNX.4.21.0112171904030.3720-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Get the backtrace of the loopback thread (using magic sysrq) and use
ksymoops to decode it using the System.map of your running kernel... 

Thanks

On Mon, 17 Dec 2001, David Gomez wrote:

> 
> Hi,
> 
> Even with the Andrea/Monchil patch applied against 2.4.17-rc1, i'm still
> hitting the loopback deadlock. Doing a 'cp -a' to a loop device leaves cp
> and the loop kernel thread in D state.
> 
> I don't know if it's useful, but i did a strace of cp, and the process is
> deadlocked in a mkdir call. Sometimes, a 'sync' finish the deadlock, other
> times sync also hangs:
> 
> [...]
> 589 tty1     S      0:00 bash
> 594 ?        DW<    0:00 [loop0]
> 620 tty1     D      0:00 sync
> 
> And a reboot is the only way to kill the tasks.
> 
> 
> Thanks
> 
> David Gómez
> 
> "The question of whether computers can think is just like the question of
>  whether submarines can swim." -- Edsger W. Dijkstra
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

