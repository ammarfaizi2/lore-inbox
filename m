Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271796AbRHRIvC>; Sat, 18 Aug 2001 04:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271797AbRHRIux>; Sat, 18 Aug 2001 04:50:53 -0400
Received: from hr1-cf9a48a7.dsl.impulse.net ([207.154.72.167]:38673 "HELO
	madrabbit.org") by vger.kernel.org with SMTP id <S271796AbRHRIuq>;
	Sat, 18 Aug 2001 04:50:46 -0400
Subject: Re: [PATCH 2.4.8-ac6] (Yet) Another Sony Vaio laptop with a broken
	APM...
From: Ray Lee <ray-lk@madrabbit.org>
To: Dave Zarzycki <dave@zarzycki.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0108171005440.2165-100000@batman.zarzycki.org>
In-Reply-To: <Pine.LNX.4.33.0108171005440.2165-100000@batman.zarzycki.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12 (Preview Release)
Date: 18 Aug 2001 01:50:59 -0700
Message-Id: <998124659.440.15.camel@orca>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Aug 2001 10:08:25 -0700, Dave Zarzycki wrote:
> On 17 Aug 2001, Ray Lee wrote:
> > It's looking more and more likely that they're all backwards. Hey, at
> > least they're consistent, right?
> My old Sony PCG-505G does seem to get it right.

Hmm. You may be taken care of by one of the exceptions already in
dmi_scan.c, and it'd be interesting (and useful) to find out. If you've
got a few minutes, could you open up arch/i386/kernel/dmi_scan.c and
either uncomment or add the line:
   #define dmi_printk(x) printk x
after the existing "#define dmi_printk(x)".

With that, upon boot the new kernel will show the BIOS version and date,
which dmesg will show. If they are one of: 

  R0203Z3  08/25/00
  R0203D0  05/12/00
  R0121Z1  05/11/00
  R0208P1  11/09/00

...then in fact your BIOS also gets it wrong, which would be
aesthetically pleasing in a sort of perverted way.

--
Ray Lee  /  Every truth has a context.


