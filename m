Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262921AbTCKNy2>; Tue, 11 Mar 2003 08:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262927AbTCKNy2>; Tue, 11 Mar 2003 08:54:28 -0500
Received: from pusa.informat.uv.es ([147.156.10.98]:26790 "EHLO
	pusa.informat.uv.es") by vger.kernel.org with ESMTP
	id <S262921AbTCKNy1>; Tue, 11 Mar 2003 08:54:27 -0500
Date: Tue, 11 Mar 2003 15:04:58 +0100
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: is irq smp affinity good for anything?
Message-ID: <20030311140458.GA15465@pusa.informat.uv.es>
References: <20030311121916.GA12625@pusa.informat.uv.es> <Pine.LNX.3.95.1030311073427.16779A-100000@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.3.95.1030311073427.16779A-100000@chaos>
User-Agent: Mutt/1.3.28i
From: uaca@alumni.uv.es
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 11, 2003 at 07:40:15AM -0500, Richard B. Johnson wrote:

Hi Richard, thanks so much for your reply

> On Tue, 11 Mar 2003 uaca@alumni.uv.es wrote:
[...]
> 
> 33 MHz machines easily handle 6,000 interrupts per second --
> unless you are trying to execute code within that interrupt
> that requires 1/6000th of a second to execute!  Perhaps it's
> not a "latency" problem, but an interrupt code-bloat problem
> where most of the stuff should be executed out of the interrupt
> context.

it seems I explained too fuzzy/I had to explain it better

what I wanted to try is avoidoiding irq latency paths in the CPU where is
executing the ISR, where I'm interested not delaying time stamps by any other
means. 

And yes... maybe I'm a little paranoid about this, but doing an 
echo <something> > /proc/irqs/[0-9]*/smp_affinity is cheap
and it's supossed? I should get better results... or not?

anyway... 

I did not expect to increase global latency to these results...
and neither to increase latency in the CPU that's receiving 
just one interrupt!

	Ulisses 

PD: I'm not doing a driver, just measuring 

                Debian GNU/Linux: a dream come true
-----------------------------------------------------------------------------
"Computers are useless. They can only give answers."            Pablo Picasso

--->	Visita http://www.valux.org/ para saber acerca de la	<---
--->	Asociación Valenciana de Usuarios de Linux		<---
 
