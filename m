Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264802AbSJOUot>; Tue, 15 Oct 2002 16:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264804AbSJOUot>; Tue, 15 Oct 2002 16:44:49 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:7609 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S264802AbSJOUoq>; Tue, 15 Oct 2002 16:44:46 -0400
Date: Tue, 15 Oct 2002 22:51:00 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Padraig O Mathuna <padraigo@yahoo.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: mapping 36 bit physical addresses into 32 bit virtual
In-Reply-To: <20021015165947.50642.qmail@web13801.mail.yahoo.com>
Message-ID: <Pine.GSO.3.96.1021015223744.23692C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Oct 2002, Padraig O Mathuna wrote:

> I'm developing some drivers for the AU1000 under
> Mountain Vista's 2.4.17 sherman release. The AU1000 is
> a MIPS based SOC with a 36 bit internal address bus
> and a 32 bit MIPS cpu.  According to the documentation
> the MIPS' TLB is able to map 32 bit virtual addresses
> to 36 bit physical addresses, however I cannot figure
> out how to get Linux to set this up.  I've looked at
> ioremap which only takes unsigned long (32bits) as an
> argument to assign a virtual address.  Is there
> another way?

 You should probably look at how CONFIG_HIGHMEM and CONFIG_64BIT_PHYS_ADDR
support is implemented and add an option like CONFIG_36BIT_PHYS_ADDR (or
just use CONFIG_HIGHMEM for that) plus a few necessary bits to the mm code
so that ioremap() can make use of the additional bits.  It doesn't seem
too difficult to develop, but you may want to work on a current snapshot
from the CVS. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

