Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264302AbUDSKgx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 06:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263721AbUDSKgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 06:36:53 -0400
Received: from mail.shareable.org ([81.29.64.88]:7076 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S264302AbUDSKgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 06:36:52 -0400
Date: Mon, 19 Apr 2004 11:36:47 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: chris@scary.beasts.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use get_user for 64-bit read in sendfile64
Message-ID: <20040419103647.GE13007@mail.shareable.org>
References: <Pine.LNX.4.58.0404180026490.16486@sphinx.mythic-beasts.com> <Pine.LNX.4.58.0404172005260.23917@ppc970.osdl.org> <20040419004657.GD11064@mail.shareable.org> <Pine.LNX.4.58.0404182220470.2808@ppc970.osdl.org> <20040419094408.GA13007@mail.shareable.org> <20040419101446.GC13007@mail.shareable.org> <20040419101731.GD13007@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040419101731.GD13007@mail.shareable.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> Use get_user instead of copy_from_user to read a loff_t.
> Compiled output is identical on i386.

Fwiw, all architectures have 64-bit get_user except i386 (prior to
earlier patch), SH and PPC32.

PPC is weird: it has a get_user64 macro which allows 64 bits.
ARM is also weird: it has 64-bit get_user, but not __get_user.

-- Jamie
