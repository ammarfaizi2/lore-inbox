Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319116AbSHMTsr>; Tue, 13 Aug 2002 15:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319117AbSHMTsr>; Tue, 13 Aug 2002 15:48:47 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16901 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319116AbSHMTsq>; Tue, 13 Aug 2002 15:48:46 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch] clone_startup(), 2.5.31-A0
Date: 13 Aug 2002 12:52:11 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <ajbo1b$e2a$1@cesium.transmeta.com>
References: <Pine.LNX.4.44.0208131650230.30647-100000@localhost.localdomain> <20020813160924.GA3821@codepoet.org> <20020813171138.A12546@infradead.org> <15705.13490.713278.815154@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <15705.13490.713278.815154@napali.hpl.hp.com>
By author:    David Mosberger <davidm@napali.hpl.hp.com>
In newsgroup: linux.dev.kernel
> 
> The original clone() system call was misdesigned.  Even if you chose
> to ignore ia64, clone() cannot be used by portable applications to
> specify a stack (think "stack-growth direction").
> 

This is something that can be handled in userspace on most
architectures.  The rest (ia64) can pass all the information on to
kernel space.

The clone() system call cannot be used by portable applications *AT
ALL*, since it inherently needs a user-space assembly wrapper.  It's
just a matter of how you define the interface to the assembly wrapper.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
