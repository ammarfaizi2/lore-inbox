Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261651AbSI0J0R>; Fri, 27 Sep 2002 05:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261660AbSI0J0R>; Fri, 27 Sep 2002 05:26:17 -0400
Received: from kim.it.uu.se ([130.238.12.178]:57008 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S261651AbSI0J0Q>;
	Fri, 27 Sep 2002 05:26:16 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15764.9570.474736.695183@kim.it.uu.se>
Date: Fri, 27 Sep 2002 11:31:14 +0200
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Does kernel use system stdarg.h?
In-Reply-To: <200209270826.g8R8Q1p08145@Port.imtp.ilyichevsk.odessa.ua>
References: <200209270804.g8R84cp08026@Port.imtp.ilyichevsk.odessa.ua>
	<20020927092647.A7485@flint.arm.linux.org.uk>
	<200209270826.g8R8Q1p08145@Port.imtp.ilyichevsk.odessa.ua>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko writes:
 > On 27 September 2002 06:26, Russell King wrote:
 > > > There is no stdarg.h in kernel tree, should it be there?
 > > > For now I just copied GCC one into linux/include...
 > >
 > > It must be the GCC one.  If your GCC isn't finding it, then you've got a
 > > broken GCC installation; "-iwithprefix include" tells GCC to look in its
 > > private include directory for such things.
 > >
 > > You could try adding -v to CFLAGS to see where it is searching for
 > > includes.
 > 
 > Oh, I thought we don't depend on any system/GCC headers. :-(

GCC headers != glibc headers
GCC's headers are needed for stdarg and other stuff requiring compiler magic.
