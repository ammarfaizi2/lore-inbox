Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261417AbSJITLJ>; Wed, 9 Oct 2002 15:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261527AbSJITLJ>; Wed, 9 Oct 2002 15:11:09 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:32240 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S261417AbSJITKv>; Wed, 9 Oct 2002 15:10:51 -0400
Date: Wed, 9 Oct 2002 12:08:19 -0700
From: Chris Wright <chris@wirex.com>
To: Tony Glader <Tony.Glader@blueberrysolutions.com>
Cc: Chris Wright <chris@wirex.com>, linux-kernel@vger.kernel.org
Subject: Re: capable()-function
Message-ID: <20021009120819.A25392@figure1.int.wirex.com>
Mail-Followup-To: Tony Glader <Tony.Glader@blueberrysolutions.com>,
	Chris Wright <chris@wirex.com>, linux-kernel@vger.kernel.org
References: <20021009112254.A25393@figure1.int.wirex.com> <Pine.LNX.4.44.0210092135240.411-100000@blueberrysolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0210092135240.411-100000@blueberrysolutions.com>; from Tony.Glader@blueberrysolutions.com on Wed, Oct 09, 2002 at 09:39:18PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Glader (Tony.Glader@blueberrysolutions.com) wrote:
> On Wed, 9 Oct 2002, Chris Wright wrote:
> 
> > > I was investigating problems with PCMCIA and found that
> > > capable(CAP_SYS_ADMIN) returns always false in my case. If I'm calling
> > Typically root has all effective capabilities (except CAP_SETPCAP).
> > You can check your effective capabilities in /proc/[pid]/status.
> 
> In this case capable() call has been made from a kernel module. I think a
> module doesn't have a PID? Should I check capabilites of program that does
> a ioctl() call that will cause module to do capable() checking?

The userspace task that called the ioctl() is the one to look at.

> Process that does ioctl() call is owned by root and has following 
> capabilities:
> 
> CapInh: 0000000000000000
> CapPrm: 00000000fffffeff
> CapEff: 00000000fffffeff

Ok, I don't think the capable() check is failing.
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
