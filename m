Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263796AbUAXCSc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 21:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266670AbUAXCSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 21:18:32 -0500
Received: from palrel13.hp.com ([156.153.255.238]:11462 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S263796AbUAXCS3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 21:18:29 -0500
Date: Fri, 23 Jan 2004 18:18:28 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       irda-users@lists.sourceforge.net
Cc: Jeff Garzik <jgarzik@pobox.com>, Martin Diehl <lists@mdiehl.de>
Subject: New IrDA drivers for 2.6.X
Message-ID: <20040124021828.GA22410@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Dave,

	Martin Diehl has finished converting all the old style dongle
driver to the new API. This was the last major feature parity issue
with 2.4.X, with this work, 2.6.X should support all the IrDA serial
dongles that 2.4.X supports. Martin also did a few other cleanups and
fixed tekram-sir so that it works with real hardware.
	All patches depend on the first patch, and the last patch
depend on the previous patches. I tested this on 2.6.2-rc1 with an
actisys dongle, neither Martin or I have hardware to test the other
dongle drivers.
	Thanks for pushing that to "you know who" ;-)

	Jean

--------------------------------------------------------

ir262_dongles-1_sir-dev.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Needed by all subsequent patches>
		<Patch from Martin Diehl>
* change dongle api such that raw r/w and modem line helpers are directly
  called, not virtual callbacks.

ir262_dongles-2_actisys-sir.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Martin Diehl>
* convert to de-virtualized sirdev helpers
* improve error path during speed change

ir262_dongles-3_esi-sir.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Martin Diehl>
* convert to de-virtualized sirdev helpers
* add probably missing dongle power-up operation

ir262_dongles-4_tekram-sir-2.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Martin Diehl>
* increase default write-delay to 150msec
* convert to de-virtualized sirdev helpers

ir262_dongles-5_litelink-sir-2.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Eugene Crosser>
* converted for new api from old driver
		<Patch from Martin Diehl>
* convert to de-virtualized sirdev helpers
* set dongle to 9600 in case of invalid speed instead leaving it in
  unknown configuration

ir262_dongles-6_act200l-sir.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Martin Diehl>
* converted for new api from old driver

ir262_dongles-7_girbil-sir.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Martin Diehl>
* converted for new api from old driver

ir262_dongles-8_ma600-sir.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Martin Diehl>
* converted for new api from old driver

ir262_dongles-9_mcp2120-sir.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Martin Diehl>
* converted for new api from old driver

ir262_dongles-10_belkin-sir.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Martin Diehl>
* converted for new api from old driver

ir262_dongles-11_makefile-2.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		<apply after all other patches>
		<Patch from Martin Diehl>
* include build information for new dongle drivers (5->10)
