Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261274AbSJLPYF>; Sat, 12 Oct 2002 11:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261273AbSJLPYE>; Sat, 12 Oct 2002 11:24:04 -0400
Received: from cpe.atm4-0-51259.0x50a02f76.odnxx3.customer.tele.dk ([80.160.47.118]:56734
	"EHLO gw.sparre.dk") by vger.kernel.org with ESMTP
	id <S261274AbSJLPYD>; Sat, 12 Oct 2002 11:24:03 -0400
Message-ID: <3DA83FE8.A6B489BD@sparre.dk>
Date: Sat, 12 Oct 2002 17:29:44 +0200
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
References: <5.1.0.14.2.20021010115616.04a0de70@localhost> <4386E3211F1@vcnet.vc.cvut.cz> <5.1.0.14.2.20021010115616.04a0de70@localhost> <20021010182740.A23908@infradead.org> <5.1.0.14.2.20021010140426.0271c6a0@localhost> <20021011180209.A30671@infradead.org> <20021011142657.B32421@openss7.org> <3DA78926.FB2299A@sparre.dk> <20021012035642.B14955@openss7.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Brian F. G. Bidulock" wrote:
> Is you concern that LiS
> using a _GPL only facility will force GPL on modules linked with LiS
> even though LiS is LGPL?

No, my concern is that the kernel should be marked as
tainted when appropriate, thus giving volunteer kernel
hackers a change to decide if they want to help with an
oops from a tainted kernel.

For well-defined fundamental interfaces between genuinely
seperate works, I think using EXPORT_SYMBOL is more
appropriate than EXPORT_SYMBOL_GPL.
Syscalls like putpmsg and getpmsg fall into this category,
even if wrapped in a thin layer to facilitate MP-safe
registration and deregistration.

The simple act of a LGPL module hooking two syscalls not
implemented by the standard kernel is IMHO no good reason
for marking the kernel as such tainted.

Best Regards,

Ole Husgaard.
