Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263805AbUA3Ivm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 03:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266322AbUA3Ivm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 03:51:42 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:35591 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263805AbUA3Ivk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 03:51:40 -0500
Date: Fri, 30 Jan 2004 08:51:36 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: root <root@ohlone.ucsc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: net-pf-10, 2.6.1
Message-ID: <20040130085136.C9894@flint.arm.linux.org.uk>
Mail-Followup-To: root <root@ohlone.ucsc.edu>, linux-kernel@vger.kernel.org
References: <E1AmU8a-00005E-00@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E1AmU8a-00005E-00@localhost>; from root@ohlone.ucsc.edu on Fri, Jan 30, 2004 at 12:36:28AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 30, 2004 at 12:36:28AM -0800, root wrote:
> Is there any guidance about this little annoyance yet? Most of the
> advice I've seen (on other lists) suggests putting the following in
> modprobe.conf:
> 
>    install net-pf-10 /bin/true

You want:

	alias net-pf-10 off

> Almost all of the error messages from modprobe come exactly on the
> heels of a call from cron to run exim. But why should exim spawn an 
> attempt to load this module? And why just with kernel 2.6.1?

Because its trying to see if the kernel supports IPv6 by creating an
IPv6 socket.  Since the IPv6 module is not available, it correctly
fails and uses IPv4 instead.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
