Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287895AbSAPV0B>; Wed, 16 Jan 2002 16:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287882AbSAPVYh>; Wed, 16 Jan 2002 16:24:37 -0500
Received: from zero.tech9.net ([209.61.188.187]:15626 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S287886AbSAPVXj>;
	Wed, 16 Jan 2002 16:23:39 -0500
Subject: Re: [PATCH] I3 sched tweaks...
From: Robert Love <rml@tech9.net>
To: Justin Carlson <justincarlson@cmu.edu>
Cc: mingo@elte.hu, Rusty Russell <rusty@rustcorp.com.au>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1011215946.314.14.camel@gs256.sp.cs.cmu.edu>
In-Reply-To: <Pine.LNX.4.33.0201162343290.18971-100000@localhost.localdomain> 
	<1011215440.814.82.camel@phantasy> 
	<1011215946.314.14.camel@gs256.sp.cs.cmu.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 16 Jan 2002 16:27:09 -0500
Message-Id: <1011216429.1083.95.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-01-16 at 16:19, Justin Carlson wrote:

> Don't forget that, in non-x86 land, current tends to be just kept in a 
> register.  No computations required.  Certainly passing it around on,
> e.g. mips is a clear loss.

current is stored in a register (esp) in x86, too.  This is why I
cautioned that looking up current was cheap -- I think every sane arch
stores current in some fast access way.  That's why it is a macro -- it
is assembly code to quickly snag the address.

So is passing current still worth it?

	Robert Love

