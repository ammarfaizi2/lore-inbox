Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282917AbRLQWNG>; Mon, 17 Dec 2001 17:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282919AbRLQWM4>; Mon, 17 Dec 2001 17:12:56 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:30992 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S282917AbRLQWMl>; Mon, 17 Dec 2001 17:12:41 -0500
Date: Mon, 17 Dec 2001 22:12:29 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: "Ahmed, Zameer" <Zameer.Ahmed@gs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Turning off nagle algorithm in 2.2.x and 2.4.x kernels?
Message-ID: <20011217221229.B6418@flint.arm.linux.org.uk>
In-Reply-To: <FBC7494738B7D411BD7F00902798761908BFF190@gsny49e.ny.fw.gs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <FBC7494738B7D411BD7F00902798761908BFF190@gsny49e.ny.fw.gs.com>; from Zameer.Ahmed@gs.com on Mon, Dec 17, 2001 at 04:03:15PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2001 at 04:03:15PM -0500, Ahmed, Zameer wrote:
> Hi,
> 	Is there a way to turn off nagle compression in the kernel for 2.2.x
> and 2.4.x kernels? For the same custom app used under Solaris and Linux.
> Turning off nagle algorithm boosted perf on Solaris, I tried commenting out
> 
> #bool 'IP: Disable NAGLE algorithm (normally enabled)' CONFIG_TCP_NAGLE_OF
> 
> from the net/ipv4/Config.in 2.2.19 kernel and still the degradation in
> network performance for packts in midsize persists
> I tried the 2.4.16 kernel. This gave me very slight improvement, but not
> quite what is expected.

Erm, commenting out a configure option to turn something off doesn't turn
that item off.  It just leaves you without the question (and the feature
remains on).

You want to say 'y' to this option to disable nagle.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

