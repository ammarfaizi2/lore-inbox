Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280987AbRKLUnK>; Mon, 12 Nov 2001 15:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280982AbRKLUnB>; Mon, 12 Nov 2001 15:43:01 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:55307 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S280985AbRKLUml>; Mon, 12 Nov 2001 15:42:41 -0500
Date: Mon, 12 Nov 2001 17:24:27 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: "Gord R. Lamb" <glamb@max-t.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: I/O lockup
In-Reply-To: <Pine.LNX.4.21.0111121617150.1064-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0111121723310.1160-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Well, Arjan just told me that qla2x00 is doing weird shit. He seems to be
fixing it... 

On Mon, 12 Nov 2001, Marcelo Tosatti wrote:

> 
> 
> On Mon, 12 Nov 2001, Gord R. Lamb wrote:
> 
> > Hi everyone,
> > 
> > I've been having a problem for a while now with a strange lockup induced
> > under heavy SCSI I/O (particularly when I write directly to block devices
> > with dd of=/dev/sd?, but also when writing to a filesystem on that
> > device).  I'm writing around 50-100mb/sec over FC (qlogic 2200) under
> > Linux 2.4 (tried 2.4.3 through 2.4.10).
> > 
> > It seems that some vm or I/O related spinlock is being taken and held, but
> > not released (?).  There is no oops or BUG() or anything (no messages at
> > all in fact).. all I/O just stops.  I can still invoke sysrq, type
> > characters at the console, etc.  In fact, usually top continues to run and
> > display kswapd as the dominant process.
> 
> If kswapd is eating the CPU, its probably a VM problem.
> 
> Please try the newest 2.4.xx which has VM updates and if the problem
> happens again, tell us.
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

