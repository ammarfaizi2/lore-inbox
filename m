Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288555AbSADJJm>; Fri, 4 Jan 2002 04:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288559AbSADJJa>; Fri, 4 Jan 2002 04:09:30 -0500
Received: from mail.s.netic.de ([212.9.160.11]:15123 "EHLO mail.netic.de")
	by vger.kernel.org with ESMTP id <S288557AbSADJJP>;
	Fri, 4 Jan 2002 04:09:15 -0500
To: dewar@gnat.com
Cc: Dautrevaux@microprocess.com, paulus@samba.org,
        Franz.Sirl-kernel@lauterbach.com, benh@kernel.crashing.org,
        gcc@gcc.gnu.org, jtv@xs4all.nl, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.linuxppc.org, minyard@acm.org, rth@redhat.com,
        trini@kernel.crashing.org, velco@fadata.bg
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <20020103132837.71EFBF3257@nile.gnat.com>
From: Florian Weimer <fw@deneb.enyo.de>
Date: Fri, 04 Jan 2002 09:38:35 +0100
In-Reply-To: <20020103132837.71EFBF3257@nile.gnat.com> (dewar@gnat.com's
 message of "Thu,  3 Jan 2002 08:28:37 -0500 (EST)")
Message-ID: <87wuyy33zo.fsf@deneb.enyo.de>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) Emacs/21.1 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dewar@gnat.com writes:

> <<No, in fact the kernel isn't written in ANSI C. :)
> If nothing else, the fact that it uses a lot of gcc-specific
> extensions rules that out.  And it assumes that you can freely cast
> pointers to unsigned longs and back again.  I'm sure others can add to
> this list.
>>>
>
> Most certainly this list should exist in precise defined form. 

C99 includes a list of additional guarantees made by many C
implementations (in an informative index).  I think we really should
check this list (and the list of implementation-defined behavior) and
document the choices made by GCC.  In fact, this documentation is
required by the standard.

> It is this kind of informality that is asking for trouble.

We have seen much trouble in this area before, but I doubt we can
avoid all of them by proper documentation.  Quite a few people seem to
write some C code, check that it works, look at the generated machine
code, and if it seems to be correct, the C code is considered to be
correct.
