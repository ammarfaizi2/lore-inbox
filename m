Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266609AbSKZT3P>; Tue, 26 Nov 2002 14:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266564AbSKZT2j>; Tue, 26 Nov 2002 14:28:39 -0500
Received: from [81.2.122.30] ([81.2.122.30]:4868 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S266609AbSKZT1p>;
	Tue, 26 Nov 2002 14:27:45 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200211261945.gAQJjoRe000267@darkstar.example.net>
Subject: Re: A Kernel Configuration Tale of Woe
To: trog@wincom.net
Date: Tue, 26 Nov 2002 19:45:50 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, dpaun@rogers.com, rusty@linux.co.intel.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <3de3cc8d.54dd.0@wincom.net> from "Dennis Grant" at Nov 26, 2002 02:28:29 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > For boards its not that simple. Many vendors release multiple >
> > utterly different machines with the same box, bios and ident.
> > The customer is told "IDE CD, 100mbit ethernet", the customer
> > gets random cheapest going ethernet.
> 
> Agreed - so then the association between "board" and "chipset" must
> be capable of being multi-valued, and when there is a mult-valued
> match there must be some means of further interrogating the user (or
> user agent) for more information.

This demonstrates a very important point - _any_ automatic
configuration program is likely to cause more traffic to this mailing
list, and create more work for users and developers that the current
automatic configuration process:

echo 'My box doesn't boot' | mail linux-kernel@vger.kernel.org

The kernel knows nothing about motherboards, cards, etc.  It knows
about chipsets, and nothing else.  By definition, you cannot have a
kernel configurator that works at a higher level than that.

Why don't we introduce a make allworkingmodules config, which compiles
everything as modules, except for the things that are broken as
modules, (for example IDE in the current 2.5.x tree would be compiled
in).

John.
