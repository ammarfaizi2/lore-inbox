Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261997AbTCLV7h>; Wed, 12 Mar 2003 16:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261999AbTCLV7h>; Wed, 12 Mar 2003 16:59:37 -0500
Received: from divine.city.tvnet.hu ([195.38.100.154]:21313 "EHLO
	divine.city.tvnet.hu") by vger.kernel.org with ESMTP
	id <S261997AbTCLV7f>; Wed, 12 Mar 2003 16:59:35 -0500
Date: Wed, 12 Mar 2003 23:03:20 +0100 (MET)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63)) 
In-Reply-To: <200303122113.h2CLDSfR032057@pincoya.inf.utfsm.cl>
Message-ID: <Pine.LNX.4.30.0303122255270.18833-100000@divine.city.tvnet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Mar 2003, Horst von Brand wrote:

> It is _hard_ to do with variable length instructions (CISC, remember?), the
> code is designed to be easily decoded forward, noone executes code going
> backwards.

Of course, it's a bad approach. You start earlier and stop at EIP.
Repeat this for max(instruction length) different offsets and you will
have the winner. Figure it out from the context after EIP.

> When I needed to look at the code in an Oops I'd either objdump(1)ed it or
> compiled the offending stuff to assembler (possibly with custom CFLAGS to
> get info on line numbers and such in the output).

I was talking about cases when you can't do these.

	Szaka

