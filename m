Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264603AbTK0TqL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 14:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264602AbTK0TqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 14:46:11 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37903 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264603AbTK0TqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 14:46:09 -0500
Date: Thu, 27 Nov 2003 19:46:02 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "YOSHIFUJI Hideaki / ?$B5HF#1QL@?(B" <yoshfuji@linux-ipv6.org>
Cc: felipe_alfaro@linuxmail.org, davem@redhat.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH 2.6]: IPv6: strcpy -> strlcpy
Message-ID: <20031127194602.A25015@flint.arm.linux.org.uk>
Mail-Followup-To: "YOSHIFUJI Hideaki / ?$B5HF#1QL@?(B" <yoshfuji@linux-ipv6.org>,
	felipe_alfaro@linuxmail.org, davem@redhat.com,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com
References: <20031127.173320.19253188.yoshfuji@linux-ipv6.org> <20031127025921.3fed8dd4.davem@redhat.com> <1069934643.2393.0.camel@teapot.felipe-alfaro.com> <20031127.210953.116254624.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031127.210953.116254624.yoshfuji@linux-ipv6.org>; from yoshfuji@linux-ipv6.org on Thu, Nov 27, 2003 at 09:09:53PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 27, 2003 at 09:09:53PM +0900, YOSHIFUJI Hideaki / ?$B5HF#1QL@?(B wrote:
> In article <1069934643.2393.0.camel@teapot.felipe-alfaro.com> (at Thu, 27 Nov 2003 13:04:04 +0100), Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> says:
> 
> > On Thu, 2003-11-27 at 11:59, David S. Miller wrote:
> > 
> > > I agree, using sizeof() is the less error prone way of
> > > doing things like this.
> > > 
> > > Felipe could you please rewrite your patch like this?
> > 
> > Done!
> 
> Thanks. Ok to me.

I'm slightly cautious here, although I haven't read the patch yet.
Did anyone consider whether any of these structures were copied to
user space, and whether, as a result of this change, we're now
copying uninitialised data to users?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
