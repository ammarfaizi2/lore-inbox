Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263263AbTCNHdl>; Fri, 14 Mar 2003 02:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263264AbTCNHdl>; Fri, 14 Mar 2003 02:33:41 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:58375 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S263263AbTCNHdl>; Fri, 14 Mar 2003 02:33:41 -0500
Message-Id: <200303140718.h2E7IKu06478@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Szakacsits Szabolcs <szaka@sienet.hu>
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63))
Date: Fri, 14 Mar 2003 09:14:59 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <200303132104.h2DL4TKf005825@eeyore.valparaiso.cl>
In-Reply-To: <200303132104.h2DL4TKf005825@eeyore.valparaiso.cl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 March 2003 23:04, Horst von Brand wrote:
> Szakacsits Szabolcs <szaka@sienet.hu> said:
> > On Wed, 12 Mar 2003, Horst von Brand wrote:
> > > It is _hard_ to do with variable length instructions (CISC,
> > > remember?), the code is designed to be easily decoded forward,
> > > noone executes code going backwards.
> >
> > Of course, it's a bad approach. You start earlier and stop at EIP.
> > Repeat this for max(instruction length) different offsets and you
> > will have the winner. Figure it out from the context after EIP.
>
> By hand, OK. Automatically, no.

Why not? Disassemble from, say, EIP-16 and check whether you
have an instruction starting exactly at EIP. If no, repeat from EIP-15, -14...
You are guaranteed to succeed at EIP-0  ;)
--
vda
