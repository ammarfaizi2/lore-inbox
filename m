Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWFWN6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWFWN6V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 09:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750703AbWFWN6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 09:58:05 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39869 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750714AbWFWNi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 09:38:28 -0400
Subject: Re: IPWireless 3G PCMCIA Network Driver and GPL
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Charles Majola <chmj@rootcore.co.za>
Cc: Pavel Machek <pavel@ucw.cz>, stephen@blacksapphire.com,
       benm@symmetric.co.nz, kernel list <linux-kernel@vger.kernel.org>,
       radek.stangel@gmsil.com
In-Reply-To: <449BEABD.5010305@rootcore.co.za>
References: <20060616094516.GA3432@elf.ucw.cz>
	 <20060623124405.GA8027@elf.ucw.cz>
	 <1151068832.4549.7.camel@localhost.localdomain>
	 <449BEABD.5010305@rootcore.co.za>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 23 Jun 2006 14:53:57 +0100
Message-Id: <1151070837.4549.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-06-23 am 15:21 +0200, ysgrifennodd Charles Majola:
> Alan, can you please give me pointers on the tty changes since 2.6.12?

The newest kernels have a replacement set of tty receive functions that
use a new buffering system.

http://kerneltrap.org/node/5473

covers the changes briefly. The internals of the buffering changes are
quite complex because Paul did some rather neat things with SMP locking
but the API is nice and simple.

Its fairly easy to express the old API in terms of the new one if you
are doing compat wrappers as well

Alan

