Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262867AbSJLJvA>; Sat, 12 Oct 2002 05:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262868AbSJLJvA>; Sat, 12 Oct 2002 05:51:00 -0400
Received: from gw.openss7.com ([142.179.199.224]:31249 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id <S262867AbSJLJu6>;
	Sat, 12 Oct 2002 05:50:58 -0400
Date: Sat, 12 Oct 2002 03:56:42 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Ole Husgaard <osh@sparre.dk>
Cc: Christoph Hellwig <hch@infradead.org>, David Grothe <dave@gcom.com>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org,
       LiS <linux-streams@gsyc.escet.urjc.es>, davem@redhat.com
Subject: Re: [Linux-streams] Re: [PATCH] Re: export of sys_call_tabl
Message-ID: <20021012035642.B14955@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Ole Husgaard <osh@sparre.dk>,
	Christoph Hellwig <hch@infradead.org>, David Grothe <dave@gcom.com>,
	Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org,
	LiS <linux-streams@gsyc.escet.urjc.es>, davem@redhat.com
References: <5.1.0.14.2.20021010115616.04a0de70@localhost> <4386E3211F1@vcnet.vc.cvut.cz> <5.1.0.14.2.20021010115616.04a0de70@localhost> <20021010182740.A23908@infradead.org> <5.1.0.14.2.20021010140426.0271c6a0@localhost> <20021011180209.A30671@infradead.org> <20021011142657.B32421@openss7.org> <3DA78926.FB2299A@sparre.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DA78926.FB2299A@sparre.dk>; from osh@sparre.dk on Sat, Oct 12, 2002 at 04:29:58AM +0200
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ole,

I don't think that exporting putpmsg and getpmsg as _GPL will
stop proprietary modules from being linked with LiS.  LiS exports
its symbols on a different basis.  There is no need for a proprietary
module using LiS to access putpmsg or getpmsg or the syscall
registration facility for that matter.  Is you concern that LiS
using a _GPL only facility will force GPL on modules linked with LiS
even though LiS is LGPL?

--brian

On Sat, 12 Oct 2002, Ole Husgaard wrote:

> "Brian F. G. Bidulock" wrote:
> > On Fri, 11 Oct 2002, Christoph Hellwig wrote:
> > > It is not.  Sys_call_table was exported to allow iBCS/Linux-ABI
> > 
> > I don't know if it matters, but these two calls putpmsg and getpmsg
> > are the calls used by iBCS.
> 
> AFAIK, iBCS use these syscalls to emulate TLI, and iBCS
> only has this emulation working for the IP protocol suite.
> 
> LiS is hooking the same syscalls, and is more protocol
> independent.
> 
> In this way, iBCS and LiS are competing projects, even
> if their base objectives are very different (iBCS aims
> for user-level binary portability from SysV, while LiS
> aims for kernel-level STREAMS code portability from SysV
> to extend to Linux).
> 
> > No, I don't think anyone wants proprietary syscalls to be registered
> > with this facility.  If _GPL can allow an LGPL module to use the
> > facility without problems, that will be the best way to go.
> 
> An LGPL module with proprietary code linked into it will
> taint the kernel. LiS is often linked with proprietary
> code, since it is under LGPL.
> 
> IMHO, A not-GPL-only export from the kernel is needed
> here.
> 
> That will not make these syscalls proprietary. Even with
> proprietary drivers linked into LiS, it is impossible to
> deviate from the SysV definition of putpmsg/getpmsg
> unless the code of LiS itself is modified.
> 
> Best Regards,
> 
> Ole Husgaard.

-- 
Brian F. G. Bidulock    ¦ The reasonable man adapts himself to the ¦
bidulock@openss7.org    ¦ world; the unreasonable one persists in  ¦
http://www.openss7.org/ ¦ trying  to adapt the  world  to himself. ¦
                        ¦ Therefore  all  progress  depends on the ¦
                        ¦ unreasonable man. -- George Bernard Shaw ¦
