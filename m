Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267909AbUGaImk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267909AbUGaImk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 04:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267638AbUGaImk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 04:42:40 -0400
Received: from aun.it.uu.se ([130.238.12.36]:55000 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S267914AbUGaImf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 04:42:35 -0400
Date: Sat, 31 Jul 2004 10:41:53 +0200 (MEST)
Message-Id: <200407310841.i6V8frSq021638@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: jon@oberheide.org, soete.joel@tiscali.be
Subject: Re: Some cleanup patches for: '...lvalues is deprecated'
Cc: dan@debian.org, linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com,
       vojtech@suse.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jul 2004 11:11:32 +0200, Joel Soete wrote:
>> FYI, lvalue casts are treated as errors in gcc 3.5.
>> 
>According to this kind remark, I think so that following attachement patc=
>hes
>would be interesting.

(cast-as-lvalue elimination patches omitted)

Did you know that there is a larger gcc-3.4 fixes patch:
<http://www.csd.uu.se/~mikpe/linux/patches/2.4/patch-gcc340-fixes-v4-2.4.27-rc3>
?

This patch handles all issues when using gcc-3.4 to compile
the current 2.4 kernel, of which cast-as-lvalue is just one.
The only difference, AFAIK, is that gcc-3.4 "merely" warns
about cast-as-lvalue while gcc-3.5 errors out on them.

All changes in the gcc-3.4 fixes patch are backports from
the 2.6 kernel, except in very few cases when 2.4 and 2.6
have diverged making slightly different fixes more appropriate
for 2.4.

The patch handles i386, x86-64, and ppc architecture code,
plus whatever drivers etc I've ever needed, plus drivers
etc other people have contributed or requested fixes for.
The only code I'm not considering is architecture code for
other architectures than i386/x86-64/ppc, since those are
the only ones I can compile and test.

/Mikael
