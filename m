Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271910AbRIQRT0>; Mon, 17 Sep 2001 13:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271921AbRIQRTR>; Mon, 17 Sep 2001 13:19:17 -0400
Received: from mailhost.opengroup.fr ([62.160.165.1]:20874 "EHLO
	mailhost.ri.silicomp.fr") by vger.kernel.org with ESMTP
	id <S271911AbRIQRTL>; Mon, 17 Sep 2001 13:19:11 -0400
Date: Mon, 17 Sep 2001 19:19:31 +0200 (CEST)
From: Jean-Marc Saffroy <saffroy@ri.silicomp.fr>
To: Dave Jones <davej@suse.de>
cc: <linux-kernel@vger.kernel.org>, <linux-smp@vger.kernel.org>
Subject: Re: [Q] Implementation of spin_lock on i386: why "rep;nop" ?
In-Reply-To: <Pine.LNX.4.30.0109171821340.27689-100000@Appserv.suse.de>
Message-ID: <Pine.LNX.4.31.0109171912000.26090-100000@sisley.ri.silicomp.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Sep 2001, Dave Jones wrote:

> On Mon, 17 Sep 2001, Jean-Marc Saffroy wrote:
>
> > What is the intent behind this "rep;nop" ? Does it really rely on an
> > undocumented behaviour ?
>
> Its used to stop Pentium 4's from cooking themselves.
> See the P4 manuals for more info.

Ok, I found it: actually it is the PAUSE opcode in the P4 instruction set,
and the doc for PAUSE mentions that it is equivalent to a NOP on older
IA-32 processors.

So no black magic here, except that "rep;nop" is a bit misleading, since
the Intel docs for REP and NOP do not mention PAUSE...

Thanks all for you help.


Regards,

-- 
Jean-Marc Saffroy - Research Engineer - Silicomp Research Institute
mailto:saffroy@ri.silicomp.fr

