Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262893AbVAKVq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262893AbVAKVq0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 16:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262896AbVAKVp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 16:45:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:49822 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262895AbVAKVng (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 16:43:36 -0500
Date: Tue, 11 Jan 2005 13:43:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: DHollenbeck <dick@softplc.com>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       magnus.damm@gmail.com
Subject: Re: yenta_socket rapid fires interrupts
In-Reply-To: <41E44738.2050606@softplc.com>
Message-ID: <Pine.LNX.4.58.0501111340570.2373@ppc970.osdl.org>
References: <41E2BC77.2090509@softplc.com> <Pine.LNX.4.58.0501101857330.2373@ppc970.osdl.org>
 <41E42691.3060102@softplc.com> <Pine.LNX.4.58.0501111143370.2373@ppc970.osdl.org>
 <41E44738.2050606@softplc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 11 Jan 2005, DHollenbeck wrote:
>
> Add to my last post, the information that IRQ 11 is only being used by
> the two yenta sockets. So the "toggling" is not really toggling, but the
> printing of the two card sockets which are both on the same IRQ?

Ahh. Good catch, silly me. No toggling, so you can ignore my last post. 
There's no cycle going on, and the ports are stable, and the interrupt is 
coming from somewhere else entirely.

You could still enable debugging, but at that point I'd actually be 
interested in the _first_ part of the debug output, not the long tail of 
dead interrupts. You'd need a serial console or netconsole to catch it, 
I'm afraid.

		Linus
