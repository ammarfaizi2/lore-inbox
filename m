Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262062AbSKCPyC>; Sun, 3 Nov 2002 10:54:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262076AbSKCPyC>; Sun, 3 Nov 2002 10:54:02 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:18061 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262062AbSKCPyB>; Sun, 3 Nov 2002 10:54:01 -0500
Subject: Re: Some functions are not inlined by gcc 3.2, resulting code is
	ugly
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@suse.de>
In-Reply-To: <20021103103710.D10988@devserv.devel.redhat.com>
References: <200211031125.gA3BP4p27812@Port.imtp.ilyichevsk.odessa.ua>
	<200211031322.gA3DMTp28125@Port.imtp.ilyichevsk.odessa.ua> 
	<20021103103710.D10988@devserv.devel.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Nov 2002 16:21:42 +0000
Message-Id: <1036340502.29642.36.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-11-03 at 15:37, Jakub Jelinek wrote:
> On Sun, Nov 03, 2002 at 04:14:26PM -0200, Denis Vlasenko wrote:
> > Here is the cure: force_inline will guarantee inlining.
> > 
> > To use _only_ with functions which meant to be almost
> > optimized away to nothing but are large and gcc might decide
> > they are _too_ large for inlining.
> 
> Well, you can as well bump -finline-limit, like -finline-limit=2000.
> The default is too low for kernel code (and glibc too).

I would venture the reverse interpretation for modern processors, the
kernel inlines far far too much

