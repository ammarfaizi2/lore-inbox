Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269082AbRG3Sve>; Mon, 30 Jul 2001 14:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269080AbRG3SvQ>; Mon, 30 Jul 2001 14:51:16 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:30727 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269078AbRG3SvE>; Mon, 30 Jul 2001 14:51:04 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Linux 2.4.7-ac3
Date: 30 Jul 2001 10:32:11 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9k45mr$mr1$1@cesium.transmeta.com>
In-Reply-To: <E15RBSL-0003cB-00@the-village.bc.nu> <23546.996493814@ocs3.ocs-net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Followup to:  <23546.996493814@ocs3.ocs-net>
By author:    Keith Owens <kaos@ocs.com.au>
In newsgroup: linux.dev.kernel
>
> On Mon, 30 Jul 2001 12:43:29 +0100 (BST), 
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> >How about we do
> >spec:	.version 
> >then ?
> 
> Same problem, no rule to create .version.  This should work.
> 
> spec:
> 	[ -e .version ] || echo 1 > .version
> 	. scripts/mkspec >kernel.spec
> 

The way .version is currently created is in fact a huge problem... it
means that if you do "make" as a user and then "make install" as root,
it will have to rebuild several files and relink the kernel.  My
opinion is that .version should probably be created as a side effect
of linking vmlinux.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
