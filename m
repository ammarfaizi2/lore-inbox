Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318360AbSGRW6O>; Thu, 18 Jul 2002 18:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318377AbSGRW6N>; Thu, 18 Jul 2002 18:58:13 -0400
Received: from www.transvirtual.com ([206.14.214.140]:9996 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S318360AbSGRW6K>; Thu, 18 Jul 2002 18:58:10 -0400
Date: Thu, 18 Jul 2002 16:01:01 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: willy@debian.org, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.26 broken on headless boxes
In-Reply-To: <20020718221619.GA16292@vana.vc.cvut.cz>
Message-ID: <Pine.LNX.4.44.0207181546380.16453-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> But I'll leave final decision at James, maybe he want to support
> VT without underlying console, and testing almost same condition
> on two places looks suspicious to me. Either we need blank timer
> and console, or do not. But registering one half in vty_init,
> and second half in con_init?

     This problem arises from the code being half way in between the final
results. The idea was to register a console if we have a displayed.
All we need for printk. When we detect a keyboard to attach to a display
without a keyboard then we would register a tty device then. The idea was
to allow for a setup like having one keyboard and one display as your
normal tty and a extra display as printk display. The code will be
changing lot over the next few weeks.


