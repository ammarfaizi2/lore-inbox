Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268697AbUJUMrB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268697AbUJUMrB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 08:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269031AbUJUMp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 08:45:27 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39948 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S268697AbUJUMkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 08:40:02 -0400
Date: Thu, 21 Oct 2004 13:39:53 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Paul <set@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux v2.6.9 (Strange tty problem?)
Message-ID: <20041021133953.A13876@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Paul <set@pobox.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org> <20041021024132.GB6504@squish.home.loc> <1098349651.17067.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1098349651.17067.3.camel@localhost.localdomain>; from alan@lxorguk.ukuu.org.uk on Thu, Oct 21, 2004 at 10:07:42AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 10:07:42AM +0100, Alan Cox wrote:
> On Iau, 2004-10-21 at 03:41, Paul wrote:
> > permanently unresponsive. (this burst of 'noise', seems to happen
> > periodicly, and is a repetition of this:
> > ~}#!}!}!} }8}!}$}"} }"}&} } } } }%}&]O='}'}"}(}"D~ 	)
> 
> Thats a PPP LCP conf request as far as I can decode it. You've got
> a stuck pppd somewhere - thats a minor bug in 2.6.9rc and 2.6.9 that got
> introduced by the tty changes. I'll try and fix it ASAP if Paul doesn't
> beat me to it.

I'm seeing random failures of krb5 login with 2.6.9 kernels - which has
happened somewhere between 2.6.8.1 and 2.6.9-rc3.  It's proving impossible
to debug because stracing eklogin results in the problem completely
vanishing.

Without the strace, it's reproducable in about 50% of cases.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
