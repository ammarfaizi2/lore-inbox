Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262266AbSJ0D54>; Sat, 26 Oct 2002 23:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262273AbSJ0D54>; Sat, 26 Oct 2002 23:57:56 -0400
Received: from smtp01.fields.gol.com ([203.216.5.131]:63649 "EHLO
	smtp01.fields.gol.com") by vger.kernel.org with ESMTP
	id <S262266AbSJ0D5z>; Sat, 26 Oct 2002 23:57:55 -0400
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]: linux-2.5.44uc1 (MMU-less support)
In-Reply-To: <fa.fd5mvtv.9gon33@ifi.uio.no>
References: <fa.fd5mvtv.9gon33@ifi.uio.no>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
From: Miles Bader <miles@gnu.org>
Date: 27 Oct 2002 13:04:07 +0900
Message-ID: <87iszosf2g.fsf@tc-1-100.kawasaki.gol.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Abuse-Complaints: abuse@gol.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org>:
>  +arch/$(ARCH)/kernel/asm-offsets.s: include/asm include/linux/version.h \
>  +                                  include/config/MARKER
>  +
>  +include/asm-$(ARCH)/asm-offsets.h.tmp: arch/$(ARCH)/kernel/asm-offsets.s
>  +       @$(generate-asm-offsets.h) < $< > $@
>  +
>  +include/asm-$(ARCH)/asm-offsets.h: include/asm-$(ARCH)/asm-offsets.h.tmp
>  +       @echo -n '  Generating $@'
>  +       @$(update-if-changed)
>
>  Combine it like this instead:
>
>  include/asm-$(ARCH)/asm-offsets.h: arch/$(ARCH)/kernel/asm-offsets.s \
>                                     include/asm include/linux/version.h \
>                                     include/config/MARKER
>          @echo -n '  Generating $@'
>          @$(generate-asm-offsets.h) < $< > $@
>          @$(update-if-changed)
>
>  Thats more readable, and follow te normal way of doing it.

It may be more readable, but I don't think you can say it's the `normal way
of doing it,' at least in linux -- almost all the arch Makefiles have code
pretty much identical to Greg's (presumably all derived from a single
original source).

Perhaps they should all be changed.

-Miles

[the threading info on this msg is wrong because MARC's `Download message
 RAW' option doesn't provide the message headers; quite annoying, that...]
-- 
"1971 pickup truck; will trade for guns"
