Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267116AbSKMHCC>; Wed, 13 Nov 2002 02:02:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267118AbSKMHCB>; Wed, 13 Nov 2002 02:02:01 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:37649 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S267116AbSKMHB5>; Wed, 13 Nov 2002 02:01:57 -0500
Message-Id: <200211130703.gAD73Up13033@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "J.A. Magall?n" <jamagallon@able.es>
Subject: Re: Some functions are not inlined by gcc 3.2, resulting code is ugly
Date: Wed, 13 Nov 2002 09:54:50 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200211031125.gA3BP4p27812@Port.imtp.ilyichevsk.odessa.ua> <200211031928.gA3JSSp29136@Port.imtp.ilyichevsk.odessa.ua> <20021113012854.GA1806@werewolf.able.es>
In-Reply-To: <20021113012854.GA1806@werewolf.able.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 November 2002 23:28, J.A. Magall?n wrote:
> On 2002.11.04 Denis Vlasenko wrote:
> [...]
>
> > __constant_c_and_count_memset *has to* be inlined.
> > There is large switch statement which meant to be optimized out.
> > It does optimize out *only if* count is compile-time constant.
>
> I also got tons of __copy_to_user and __copy_from_user in 2.4.
> Do not show in 2.5 ?

I haven't looked.
Maybe GCC can be told to emit warnings when it does this...

> This i what I applied to my 2.4 tree:
> [snip]

Although patch seems to achieve desired effect, it isn't
included in 2.5 yet (last time I checked). I'd like to know
verdict for 2.5 first.
--
vda
