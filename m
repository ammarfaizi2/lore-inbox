Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262165AbTCRGGH>; Tue, 18 Mar 2003 01:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262170AbTCRGGH>; Tue, 18 Mar 2003 01:06:07 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:13070 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S262165AbTCRGGG>; Tue, 18 Mar 2003 01:06:06 -0500
Message-Id: <200303180608.h2I68mu23488@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63))
Date: Tue, 18 Mar 2003 08:05:30 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <200303172143.h2HLhLql010853@pincoya.inf.utfsm.cl>
In-Reply-To: <200303172143.h2HLhLql010853@pincoya.inf.utfsm.cl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 March 2003 23:43, Horst von Brand wrote:
> Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> said:
> > On 15 March 2003 20:34, Horst von Brand wrote:
> > > Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> said:
>
> [...]
>
> > > > Why not? Disassemble from, say, EIP-16 and check whether you
> > > > have an instruction starting exactly at EIP. If no, repeat from
> > > > EIP-15, -14... You are guaranteed to succeed at EIP-0  ;)
> > >
> > > But your previous success (if any) doesn't mean anything, and
> > > might even screw up the decoding after EIP
> >
> > How come? If I started to decode at EIP-n and got a sequence of
> > instructions at EIP-n, EIP-n+k1, EIP-n+k2, EIP-n+k3..., EIP,
> > instructions prior to EIP can be wrong. Instruction at EIP
> > and all subsequent ones ought to be right.
>
> Iff you exactly hit EIP that way (sure, should check). But wrong
> previous instructions _will_ confuse people or start them on all kind
> of wild goose chases. Too much work for a dubious gain.

You are right. But that is better than showing no prior instructions
at all. And most of the time (can I say 90% ?) prior instructions
will be ok.
--
vda
