Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264968AbSJPISr>; Wed, 16 Oct 2002 04:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264969AbSJPISr>; Wed, 16 Oct 2002 04:18:47 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:14331 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S264968AbSJPISq>; Wed, 16 Oct 2002 04:18:46 -0400
Date: Wed, 16 Oct 2002 01:15:20 -0700
From: Chris Wright <chris@wirex.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Daniel Phillips <phillips@arcor.de>, Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] In-kernel module loader 1/7
Message-ID: <20021016011520.A26442@figure1.int.wirex.com>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	Daniel Phillips <phillips@arcor.de>,
	Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
References: <E181Tcc-0003k0-00@starship> <20021016021949.DB2A92C2C1@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021016021949.DB2A92C2C1@lists.samba.org>; from rusty@rustcorp.com.au on Wed, Oct 16, 2002 at 09:53:26AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Rusty Russell (rusty@rustcorp.com.au) wrote:
> 
> I really wish the security guys had gone down the macro path, with
> something like
> 
> #define security_check(func, default_val, ...)
> 	({ if (try_inc_mod_count(security_ops->owner))
> 		security_ops->func(__VA_ARGS__);
> 	   else
> 		default_val;
> 	})
> 
> This also allows the whole thing to vanish if
> CONFIG_SECURITY_CAPABILITIES=n, and allows more flexibility for
> schemes like "always run with preemption disabled around security ops"
> or whatever, rather than having to search for all the references to
> security_ops.

You may be seeing something like this soon.  Greg is working on some
conversions right now.  I'm not sure what the final format will be,
but it should make the work above easier.  Check out his '[RFC] change
format of LSM hooks' message from a few hours ago.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
