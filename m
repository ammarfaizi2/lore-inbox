Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129290AbRCBQNL>; Fri, 2 Mar 2001 11:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129291AbRCBQMw>; Fri, 2 Mar 2001 11:12:52 -0500
Received: from [62.172.234.2] ([62.172.234.2]:29914 "EHLO penguin.homenet")
	by vger.kernel.org with ESMTP id <S129290AbRCBQMk>;
	Fri, 2 Mar 2001 11:12:40 -0500
Date: Fri, 2 Mar 2001 16:11:51 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac7
In-Reply-To: <Pine.LNX.4.21.0103021356370.6279-100000@penguin.homenet>
Message-ID: <Pine.LNX.4.21.0103021605370.6279-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

Those formulae (both 'bus' and 'mul' calculation) are broken, I think.

If I extend 'bus' to be 4 bits instead of 2 then I can make it work on all
of my machines (or all those I tried), of course, extending the buscode[]
table appropriately.

However, the radically broken, imho, thing is that the (bus, mul) pair is
_not_ constant when I vary the bus/cpu speed settings in the "soft cpu
BIOS". If the bits of the 0x2A msr are supposed to be used for finding out
the "true" i.e. intended bus/cpu speeds (hence the label "overclocked" in
the code) then they should remain constant when one is overclocking,
right?

As for my question on the evenness of the calls to identify_cpu() --
ignore it, it was obvious, of course (called from check_bugs() on
boot_cpu_data and then on SMP on each cpu_data + id)

Regards,
Tigran

