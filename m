Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281390AbRKEWHh>; Mon, 5 Nov 2001 17:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281382AbRKEWH1>; Mon, 5 Nov 2001 17:07:27 -0500
Received: from pasky.ji.cz ([62.44.12.54]:58105 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S281381AbRKEWHQ>;
	Mon, 5 Nov 2001 17:07:16 -0500
Date: Mon, 5 Nov 2001 23:07:13 +0100
From: Petr Baudis <pasky@pasky.ji.cz>
To: Tim Jansen <tim@tjansen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Message-ID: <20011105230713.W11619@pasky.ji.cz>
Mail-Followup-To: Tim Jansen <tim@tjansen.de>, linux-kernel@vger.kernel.org
In-Reply-To: <E15zF9H-0000NL-00@wagner> <160qdn-0ZGNrUC@fmrl04.sul.t-online.com> <20011105223413.U11619@pasky.ji.cz> <160rly-1tl3XUC@fmrl05.sul.t-online.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160rly-1tl3XUC@fmrl05.sul.t-online.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So far sysctl is only used to configure kernel parameters, so there exists 
> one parameter in the system (per kernel). 
Not true.. see net.ipv* stuff - for each device, same parameters are to be set.
I see no problem in this.

> An example for devices would be mass storage devices. You may want to switch 
> DMA on and off per device. Using one-value-files you would have directories 
> called /somepath/0/dma, /somepath/1/dma and so on, and could turn on DMA on 
> device 1 by executing "echo 1 > /somepath/1/dma".
Set 1 for dev.ide.host0.bus0.target0.lun0.dma (we should stay consistent at
least with devfs, or we can give it up completely ;)

> Beside that there is the good old problem "who manages the sysctl namespace" 
> problem that is even more important if you want to use sysctl for device 
> drivers that may not even be in the kernel.
Well, why not maintainers of appropriate kernel sections, or even special
maintainer, like the one for device numbers. For each section of sysctl
namespace, subset of required ctls should be defined, obviously not restricting
optional bloat ;).

-- 

				Petr "Pasky" Baudis

UN*X programmer, UN*X administrator, hobbies = IPv6, IRC
Real Users hate Real Programmers.
Public PGP key, geekcode and stuff: http://pasky.ji.cz/~pasky/
