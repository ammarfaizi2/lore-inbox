Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269514AbTCDTCu>; Tue, 4 Mar 2003 14:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269516AbTCDTCt>; Tue, 4 Mar 2003 14:02:49 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:49416 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S269514AbTCDTCt>;
	Tue, 4 Mar 2003 14:02:49 -0500
Date: Tue, 4 Mar 2003 20:13:11 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Erlend Aasland <erlend-a@ux.his.no>
Cc: lkml <linux-kernel@vger.kernel.org>, Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH 2.5][RFC] Make mconf inform user about supported make targets
Message-ID: <20030304191311.GB1917@mars.ravnborg.org>
Mail-Followup-To: Erlend Aasland <erlend-a@ux.his.no>,
	lkml <linux-kernel@vger.kernel.org>,
	Roman Zippel <zippel@linux-m68k.org>
References: <20030304113054.GA29401@badne3.ux.his.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030304113054.GA29401@badne3.ux.his.no>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 04, 2003 at 12:30:54PM +0100, Erlend Aasland wrote:
> Scenario: I do a make menuconfig on my sparc64 machine. When mconf exits, it
> tells me "Next, you may run 'make bzImage', 'make bzdisk', or 'make install'."
> 
> Problem: These are i386-specific targets. Issuing a "make help", I see
> that {vmlinux{,.aout},tftpboot.img} are the sparc64-specific targets.
> 
> Solution: Get mconf to tell the user about arch-specific targets,
> instead of i386 targets.

I see no need for this patch.
Most architectures today (if not all) has a sensible default target.

So changing mconf to print something like:
"Next, you may run 'make' to build your kernel."

Should be a good enough guide for the user.

	Sam
