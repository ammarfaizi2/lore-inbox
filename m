Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262538AbSJBTNx>; Wed, 2 Oct 2002 15:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262539AbSJBTNx>; Wed, 2 Oct 2002 15:13:53 -0400
Received: from air-2.osdl.org ([65.172.181.6]:31362 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262538AbSJBTNw>;
	Wed, 2 Oct 2002 15:13:52 -0400
Date: Wed, 2 Oct 2002 12:18:42 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Ingo Molnar <mingo@elte.hu>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Workqueue Abstraction, 2.5.40-H7
In-Reply-To: <Pine.LNX.4.44.0210012300001.23315-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33L2.0210021213180.14122-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Oct 2002, Ingo Molnar wrote:

| i dont think i've encountered much kernel code that tried to pass
| structures along by value without a good reason - OTOH complex and
| inefficient function interfaces outweigh these instances, by far. And
| there's way too much code that has two screens full of local variable
| declarations, where in the middle a 3K big array gets easily lost to the
| eye. struct pre and postfix does not help much there.

Sounds like a good reason to have a gcc flag, or more likely a
Stanford checker or smatch checker for structs (or large typedefs :)
as return values.

| And structure pointers are almost as simple to pass around and handle as
| the basic types declared on the stack - and that is their main use. Ease
| of understanding is i think by far the most important aspect of source
| code - abuse and mistaken use of constructs is always possible, no matter
| how long the name is.

-- 
~Randy

