Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261558AbSIZWw3>; Thu, 26 Sep 2002 18:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261553AbSIZWvQ>; Thu, 26 Sep 2002 18:51:16 -0400
Received: from air-2.osdl.org ([65.172.181.6]:17418 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261550AbSIZWui>;
	Thu, 26 Sep 2002 18:50:38 -0400
Date: Thu, 26 Sep 2002 15:51:26 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Shaya Potter <spotter@cs.columbia.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: using memset in a module
In-Reply-To: <1033080562.3371.24.camel@zaphod>
Message-ID: <Pine.LNX.4.33L2.0209261550410.32681-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Sep 2002, Shaya Potter wrote:

| I have a problem using memset in a module.
|
| I've tried including <linux/string.h> or <asm/string.h> but whenever I
| compile with gcc 2.95, the resulting object has memset being an
| undefined symbol.  When I compile with gcc-3.2 it works right as is
| inline in the code and there's no symbol.
|
| has anyone seen this b4?  Is this a gcc bug? a kernel header bug? a bug
| in my coding (i.e. does one have to do anything else besides include
| <linux or asm/string.h> or have special gcc cmd line options that are
| different from whats normally needed for a module).
|
| if it matters, I'm using the debian gcc's
|
| spotter@zaphod:~/cvs/zap/virtualization$ gcc -v
| Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
| gcc version 2.95.4 20011002 (Debian prerelease)
|
| and (cutting the cruft)
| gcc version 3.2.1 20020924 (Debian prerelease)

What gcc options are you using?
You need -O2 at least.
          ^ upper-case letter O

-- 
~Randy

