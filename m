Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262655AbVAEUgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262655AbVAEUgn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 15:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262654AbVAEUgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 15:36:43 -0500
Received: from mail.portrix.net ([212.202.157.208]:40923 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S262651AbVAEUcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 15:32:21 -0500
Message-ID: <41DC4EC1.5030400@ppp0.net>
Date: Wed, 05 Jan 2005 21:32:01 +0100
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041124 Thunderbird/0.9 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Kernel cross compile tests
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been playing with gcc cross compilers lately and set up
a small test suite for linux kernels.
There is a (crude) web page summarizing the results here:
http://l4x.org/k/ .
On the web page you can nicely see that the -bk8 snapshot broke
the build for ia64, ppc64, s390 and sparc. m32r isn't
buildable anymore since 2.6.10.
2.6.10-mm1  is worse with only 4 (alpha, arm, i386, ppc) archs
buildable.
2.6.10 was quite good with 9 out of 22, 2.6.0 had 8 out of 20.

Notes:
- for frv I currently don't have a buildable gcc
  (I tried 3.3.3 and 3.4.2). There doesn't seem to be a list, web
  site, help forum for that arch. Also no entry in the MAINTAINERS
  file (2.6.10-mm1).
- for m68knommu I'm not really sure if m68k-linux is the appropriate
  toolchain, compiler complains about invalid option 5307
- dito arm26, 'as' doesn't know about 'no-fpu'
- h8300 and sh64 need a 'touch .config' before 'make defconfig'
- v850 is missing a defconfig
- sh defconfig is probably broken
- sh64 'as' has unrecognized option -isa=sh64, from help text
  it should probably be 'shmedia'

If anyone has workable configs for the non working archs I
could include them in the tests (better would be of course to
update the defconfig to anything buildable).
I'm trying to do daily runs of defconfig against -bk. I don't
know if it's useful - at least it produces a nice table :-).

Jan

ps: I'm aware of the osdl kernel testing pages, but they don't
  include that many archs nor do they test bk snapshots.

