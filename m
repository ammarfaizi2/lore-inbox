Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262333AbTJFPuS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 11:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbTJFPuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 11:50:18 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:14011 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP id S262333AbTJFPuP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 11:50:15 -0400
Date: Mon, 6 Oct 2003 17:49:51 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: John Bradford <john@grabjohn.com>, Mikael Pettersson <mikpe@csd.uu.se>,
       Dave Jones <davej@redhat.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: FDC motor left on
In-Reply-To: <Pine.LNX.4.53.0310061059220.9165@chaos>
Message-ID: <Pine.GSO.3.96.1031006174121.18687C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Oct 2003, Richard B. Johnson wrote:

> > This is not a problem to deal with in the kernel - what if there is
> > hardware other than a floppy controller at that address?
> 
> In the ix86 architecture (and it is in arch-specific code), there
> cannot be anything at this address except a floppy or nothing.
> In both cases, you are covered.

 Huh?  The floppies use ordinary I/O ports at the ISA bus, not the range
reserved for motherboard devices as, until quite recently, FDCs used to
exist solely as add-on cards (I still have one).  Any other ISA device is
free to use the port range if it's unused by anything else (e.g. no FDC
there).  Ditto for IRQ6 -- older cards used to have an option to use this
line, only newer ones often do not have it anymore, for unknown reason
(i.e. the cost is probably one).

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

