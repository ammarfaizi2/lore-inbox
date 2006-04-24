Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbWDXVjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWDXVjf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 17:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWDXVjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 17:39:35 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60072 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751308AbWDXVje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 17:39:34 -0400
Subject: Re: [RFC 1/2] irq: record edge-level setting
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060424142243.519d61f1@localhost.localdomain>
References: <20060424114105.113eecac@localhost.localdomain>
	 <Pine.LNX.4.64.0604241156340.3701@g5.osdl.org>
	 <Pine.LNX.4.64.0604241203130.3701@g5.osdl.org>
	 <1145908402.3116.63.camel@laptopd505.fenrus.org>
	 <20060424201646.GA23517@devserv.devel.redhat.com>
	 <1145911417.3116.69.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0604241354200.3701@g5.osdl.org>
	 <20060424142243.519d61f1@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 24 Apr 2006 22:49:54 +0100
Message-Id: <1145915394.1635.57.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-04-24 at 14:22 -0700, Stephen Hemminger wrote:
> Record the level vs edge-triggered status of IRQ to allow for error checks later.
> 
> Note: this is only done fir i386/x86_64.

This doesn't work for IRQ's routed via the EISA IRQ routing or for MCA
that I can see. It also seems to assume the chip state at boot is right.
For EISA you need to real the EISA irq register to see what is level and
what is edge (and work out what is EISA), for MCA it is board dependant.

