Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291778AbSBTLgo>; Wed, 20 Feb 2002 06:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291780AbSBTLgf>; Wed, 20 Feb 2002 06:36:35 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:24007 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S291778AbSBTLgR>; Wed, 20 Feb 2002 06:36:17 -0500
Date: Wed, 20 Feb 2002 13:36:02 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: george anzinger <george@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: jiffies rollover, uptime etc.
Message-ID: <20020220113602.GN1105@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	george anzinger <george@mvista.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1020218191149.14047A-100000@gatekeeper.tmr.com> <3C72BBBA.FB79F6D0@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C72BBBA.FB79F6D0@mvista.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2002 at 12:55:22PM -0800, you [george anzinger] wrote:
> > 
> > > Does this problem still exist on 64-bit machines?
> > 
> > Absolutely. But not as often ;-)
> 
> Actually you will have a VERY hard time getting it to roll over.  Issues
> of your life time, not to mention the hardware's life time.  64 bits
> makes a VERY large number and you are counting in 427 day increments. 
> Remember we have been counting seconds since 1970 in 32 bits and
> rollover is still, most likely, beyond the capability of any machine
> running today to get to.  Now consider counting in 427 day increments
> instead of seconds.

48.5 day increments, not 497. On alpha and ia64 it's 1024 jiffies per
second.

Well, ok. Majority of the 64-bit archs seem to in fact use HZ=100:

asm-alpha/param.h:#  define HZ  1024
asm-ia64/param.h:# define HZ    1024
asm-mips64/param.h:#define HZ 100
asm-ppc64/param.h:#define HZ 100
asm-s390x/param.h:#define HZ 100
asm-sparc64/param.h:#define HZ 100
asm-x86_64/param.h:#define HZ 100


-- v --

v@iki.fi
