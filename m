Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262721AbSJLCYa>; Fri, 11 Oct 2002 22:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262728AbSJLCYa>; Fri, 11 Oct 2002 22:24:30 -0400
Received: from cpe.atm4-0-51259.0x50a02f76.odnxx3.customer.tele.dk ([80.160.47.118]:16286
	"EHLO gw.sparre.dk") by vger.kernel.org with ESMTP
	id <S262721AbSJLCY2>; Fri, 11 Oct 2002 22:24:28 -0400
Message-ID: <3DA78926.FB2299A@sparre.dk>
Date: Sat, 12 Oct 2002 04:29:58 +0200
From: Ole Husgaard <osh@sparre.dk>
Organization: Sparre Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: da, en, de, sv, no
MIME-Version: 1.0
To: bidulock@openss7.org
CC: Christoph Hellwig <hch@infradead.org>, David Grothe <dave@gcom.com>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org,
       LiS <linux-streams@gsyc.escet.urjc.es>, davem@redhat.com
Subject: Re: [Linux-streams] Re: [PATCH] Re: export of sys_call_tabl
References: <5.1.0.14.2.20021010115616.04a0de70@localhost> <4386E3211F1@vcnet.vc.cvut.cz> <5.1.0.14.2.20021010115616.04a0de70@localhost> <20021010182740.A23908@infradead.org> <5.1.0.14.2.20021010140426.0271c6a0@localhost> <20021011180209.A30671@infradead.org> <20021011142657.B32421@openss7.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Brian F. G. Bidulock" wrote:
> On Fri, 11 Oct 2002, Christoph Hellwig wrote:
> > It is not.  Sys_call_table was exported to allow iBCS/Linux-ABI
> 
> I don't know if it matters, but these two calls putpmsg and getpmsg
> are the calls used by iBCS.

AFAIK, iBCS use these syscalls to emulate TLI, and iBCS
only has this emulation working for the IP protocol suite.

LiS is hooking the same syscalls, and is more protocol
independent.

In this way, iBCS and LiS are competing projects, even
if their base objectives are very different (iBCS aims
for user-level binary portability from SysV, while LiS
aims for kernel-level STREAMS code portability from SysV
to extend to Linux).

> No, I don't think anyone wants proprietary syscalls to be registered
> with this facility.  If _GPL can allow an LGPL module to use the
> facility without problems, that will be the best way to go.

An LGPL module with proprietary code linked into it will
taint the kernel. LiS is often linked with proprietary
code, since it is under LGPL.

IMHO, A not-GPL-only export from the kernel is needed
here.

That will not make these syscalls proprietary. Even with
proprietary drivers linked into LiS, it is impossible to
deviate from the SysV definition of putpmsg/getpmsg
unless the code of LiS itself is modified.

Best Regards,

Ole Husgaard.
