Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263161AbTDGAHL (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 20:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263162AbTDGAHL (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 20:07:11 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:14474 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S263161AbTDGAHK (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 20:07:10 -0400
Date: Mon, 7 Apr 2003 02:18:38 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Fredrik Jagenheim <fredde@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Maestro sound module locks up the computer
Message-ID: <20030407001838.GB14501@vana.vc.cvut.cz>
References: <20030406193707.GG917@pobox.com> <1049663795.1600.50.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049663795.1600.50.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 06, 2003 at 10:16:36PM +0100, Alan Cox wrote:
> On Sul, 2003-04-06 at 20:37, Fredrik Jagenheim wrote:
> > 8 seconds; e.g. say the clock is '16:40:10'. After 6 seconds the clock is, not
> > surprisingly, '16:40:16'; but after 8 seconds it's '16:40:10' again. I'm not
> > sure it's exactly 8 seconds though, as I've only had the chance of verifying
> > this once.
> 
> That kind of weirdness is useful info

I seen that on one computer too, with 2.5.59. For some strange reason IRQ0 from 
timer was stopped, and thus system reported jiffies + tsc / <host_cpu_freq> as 
current time, taking only 32bit tsc into account. After I disabled irqbalance, 
problem never reappered (it was two cpus PIII from Dell, with serverworks chipset 
& 8GB memory; I do not remember model number).

System worked in that state for several minutes, until it lost some NFS reply, which
it never retried due to stopped timer...
						Best regards,
							Petr Vandrovec
							vandrove@vc.cvut.cz
 
