Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313131AbSDSXsa>; Fri, 19 Apr 2002 19:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313160AbSDSXs3>; Fri, 19 Apr 2002 19:48:29 -0400
Received: from air-2.osdl.org ([65.201.151.6]:60681 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S313131AbSDSXs3>;
	Fri, 19 Apr 2002 19:48:29 -0400
Date: Fri, 19 Apr 2002 16:42:35 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Ben Greear <greearb@candelatech.com>
cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: unresolved symbol: __udivdi3
In-Reply-To: <3CC0A95A.2070000@candelatech.com>
Message-ID: <Pine.LNX.4.33L2.0204191640430.15597-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

do_div(n, base) is defined (in some versions of the div64.h
files) to be:

  n = n / base; return rem;

so the first arg is modified.

~Randy

On Fri, 19 Apr 2002, Ben Greear wrote:

| Also, for what it's worth, do_div on x86 seems to corrupt arguments
| given to it, and may do other screwy things.  I'm just going to
| go back to casting and let user-space do any precise division.
|
| David S. Miller wrote:
|
| >    From: Ben Greear <greearb@candelatech.com>
| >    Date: Fri, 19 Apr 2002 14:58:10 -0700
| >
| >    then I get another unresolved symbol:
| >    __umodi3
| >
| > Someone needs to add this routine under arch/sparc/lib/
| >
| >    I'm guessing that there is some optimization the compiler is doing that
| >    is using the mod operator somehow, but I am unsure about how to work around
| >    this.
| >
| > "guessing"?  Have a look the definition of do_div in asm-sparc/div64.h
| > it explicitly does a mod operation :-)

