Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263182AbSJGUoK>; Mon, 7 Oct 2002 16:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263183AbSJGUoK>; Mon, 7 Oct 2002 16:44:10 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18188 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263182AbSJGUoJ>; Mon, 7 Oct 2002 16:44:09 -0400
Date: Mon, 7 Oct 2002 13:49:01 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcel Holtmann <marcel@holtmann.org>
cc: <linux-kernel@vger.kernel.org>, <maxk@qualcomm.com>
Subject: Re: [PATCH] Make it possible to compile in the Bluetooth subsystem
In-Reply-To: <E17yelj-0005CD-00@pegasus>
Message-ID: <Pine.LNX.4.33.0210071347470.10749-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 7 Oct 2002, Marcel Holtmann wrote:
> 
> ChangeSet@1.709, 2002-10-07 22:08:56+02:00, marcel@holtmann.org
>   Make it possible to compile in the Bluetooth subsystem

Looks good, but you should _not_ remove the "static". Please keep the init
functions static, they will be explicitly exported to the stuff that cares
(and nobody else) by the "module_init()" thing anyway.

		Linus

