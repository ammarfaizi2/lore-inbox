Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264797AbSLTTTw>; Fri, 20 Dec 2002 14:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264907AbSLTTTw>; Fri, 20 Dec 2002 14:19:52 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:40972 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264797AbSLTTTw>; Fri, 20 Dec 2002 14:19:52 -0500
Date: Fri, 20 Dec 2002 11:28:47 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: davidm@hpl.hp.com
cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.5.x disable BAR when sizing
In-Reply-To: <15875.24790.221094.202859@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.44.0212201127550.2035-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Dec 2002, David Mosberger wrote:
>
>   Linus> One solution in the long term may be to not even probe the
>   Linus> BAR's at all in generic code, and only do it in the
>   Linus> pci_enable_dev() stuff. That way it would literally only be
>   Linus> done by the driver, who can hopefully make sure that the
>   Linus> device is ok with it.
>
> Yes, I see now that the method in the PCI spec isn't really safe
> either, so BAR-sizing probably shouldn't be done in generic code at
> all.

Note that by "long-term" I definitely mean "past 2.6", and thus if there
are some specific cases where you have trouble, those will need to just
have work-arounds for now. Maybe a PCI quirks entry or something like
that.

		Linus

