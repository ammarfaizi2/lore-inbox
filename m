Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263875AbTFPOZE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 10:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263894AbTFPOZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 10:25:04 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:49595 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263875AbTFPOZC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 10:25:02 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16109.54908.249375.482633@gargle.gargle.HOWL>
Date: Mon, 16 Jun 2003 16:38:52 +0200
From: mikpe@csd.uu.se
To: Russell King <rmk@arm.linux.org.uk>
Cc: Dominik Brodowski <linux@brodo.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.71 cardbus problem + possible solution
In-Reply-To: <20030616153253.A13312@flint.arm.linux.org.uk>
References: <16109.50492.555714.813028@gargle.gargle.HOWL>
	<20030616153253.A13312@flint.arm.linux.org.uk>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King writes:
 > On Mon, Jun 16, 2003 at 03:25:16PM +0200, mikpe@csd.uu.se wrote:
 > > 2.5.71 changed the name of the Yenta module from yenta_socket
 > > to yenta. In my case (Latitude with RH9 user-space), this
 > > prevented cardmgr from starting properly.
 > > 
 > > Quick fix: add 'alias yenta_socket yenta' to /etc/modprobe.conf,
 > > or s/yenta_socket/yenta/ in the appropriate config file (but
 > > then you make multi-booting 2.4/2.5 more difficult).
 > 
 > What do people want to do about this?  I have no particular desire to
 > answer all those emails asking about this, so unless Dominik objects,
 > I think we should just rename "yenta.c" to "yenta_socket.c" so we have
 > back-compatibility.
 > 
 > (This issue has appeared because yenta_socket.ko used to be created
 > by combining yenta.o with pci_socket.o.  Since pci_socket.c no longer
 > exists, we create the module from yenta.c directly, so its now called
 > yenta.ko.)

I'd prefer compatibility, if there are no technical reasons for
breaking it. Reverting to the old name in 2.5.72 sounds like a
good idea.
