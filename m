Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270929AbTGVRey (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 13:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270932AbTGVRey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 13:34:54 -0400
Received: from chaos.analogic.com ([204.178.40.224]:20352 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S270929AbTGVRex
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 13:34:53 -0400
Date: Tue, 22 Jul 2003 13:50:20 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Davide Libenzi <davidel@xmailserver.org>
cc: Jamie Lokier <jamie@shareable.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: asm (lidt) question
In-Reply-To: <Pine.LNX.4.55.0307221021130.1372@bigblue.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.53.0307221347400.2199@chaos>
References: <20030717152819.66cfdbaf.rddunlap@osdl.org>
 <Pine.LNX.4.55.0307171535020.4845@bigblue.dev.mcafeelabs.com>
 <Pine.LNX.4.55.0307171615580.4845@bigblue.dev.mcafeelabs.com>
 <20030722172722.GC3267@mail.jlokier.co.uk> <Pine.LNX.4.55.0307221021130.1372@bigblue.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jul 2003, Davide Libenzi wrote:

> On Tue, 22 Jul 2003, Jamie Lokier wrote:
>
> > Davide Libenzi wrote:
> > > IMHO, since "var" is really an output parameter.
> >
> > "var" is read, not written.
> > I think you are confusing "lidt" with "sidt".
>
> Actually I don't even know what I was confusing, since L and S are not
> there for nothing ;) And yes, the form with =m as input parameter should
> be corrected, even if it generates the same code.
>
>
>
> - Davide

LIDT is "load interrupt descriptor table". SIDT is "store interrupt
descriptor table". Only SIDT modifies memory. LIDT reads from memory
and puts the result into a special CPU register, therefore doesn't
modify memory.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.

