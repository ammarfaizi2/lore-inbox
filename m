Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313563AbSFBUTt>; Sun, 2 Jun 2002 16:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313571AbSFBUTs>; Sun, 2 Jun 2002 16:19:48 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:2567 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S313563AbSFBUTr>; Sun, 2 Jun 2002 16:19:47 -0400
Date: Sun, 2 Jun 2002 22:19:44 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Need help tracing regular write activity in 5 s interval
Message-ID: <20020602201944.GA13682@merlin.emma.line.org>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0206020922410.29405-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 02 Jun 2002, Thunder from the hill wrote:

> Hi,
> 
> > So: is there any trace software that can tell me "at 15:52:43.012345,
> > process 4321 marked 7 blocks dirty on device /dev/hda5" (or even more
> > detail so I can figure if it's just an atime update -- as with svscan --
> > or a write access)? And that is NOT to be attached to a specific process
> > (hint: strace is not an option).
> 
> Problem: we'd have to do that using printk. printk issues another write 
> call, which will mark things dirty. Issued is another printk, which marks 
> things dirty and issues another printk...

Need not be printk, I can also imagine allocating a buffer, switching
this trace on, exempting the tracer from bein traced, and switching the
trace off if the buffer is full.
