Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267961AbUJLWOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267961AbUJLWOW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 18:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267973AbUJLWOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 18:14:21 -0400
Received: from gate.crashing.org ([63.228.1.57]:28876 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267961AbUJLWOS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 18:14:18 -0400
Subject: Re: Totally broken PCI PM calls
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Brownell <david-b@pacbell.net>
Cc: Pavel Machek <pavel@ucw.cz>, ncunningham@linuxmail.org,
       Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200410121152.53140.david-b@pacbell.net>
References: <1097455528.25489.9.camel@gaston>
	 <200410111437.17898.david-b@pacbell.net> <20041012085349.GA2292@elf.ucw.cz>
	 <200410121152.53140.david-b@pacbell.net>
Content-Type: text/plain
Message-Id: <1097619180.908.6.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 13 Oct 2004 08:13:00 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-13 at 04:52, David Brownell wrote:

> Drivers that don't reset the controller in resume()
> will need special handling for those BIOS cases.
> That means USB HCDs, and maybe not a lot else
> yet in Linux.

Usually, at least for OHCI, you can read the controller
status and know if it got reset or is still in suspend state,
at least that how we did so far (and how apple does as well
afaik) and seems to work. I don't know about EHCI.

Ben.

