Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269503AbUI3VNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269503AbUI3VNH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 17:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269511AbUI3VNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 17:13:07 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:22928 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269503AbUI3VND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 17:13:03 -0400
Subject: Re: Serial driver hangs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Roland =?ISO-8859-1?Q?Ca=DFebohm?= 
	<roland.cassebohm@VisionSystems.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1096576200.1938.154.camel@deimos.microgate.com>
References: <200409281734.38781.roland.cassebohm@visionsystems.de>
	 <200409291607.07493.roland.cassebohm@visionsystems.de>
	 <1096467951.1964.22.camel@deimos.microgate.com>
	 <200409301816.44649.roland.cassebohm@visionsystems.de>
	 <1096571398.1938.112.camel@deimos.microgate.com>
	 <1096569273.19487.46.camel@localhost.localdomain>
	 <1096573912.1938.136.camel@deimos.microgate.com>
	 <20040930205922.F5892@flint.arm.linux.org.uk>
	 <1096574739.1938.142.camel@deimos.microgate.com>
	 <1096576200.1938.154.camel@deimos.microgate.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096575030.19487.50.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 30 Sep 2004 21:10:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-09-30 at 21:30, Paul Fulghum wrote:
> tty->flip.work.func and tty->flip.tqueue.routine
> are set to flush_to_ldisc()

flush_to_ldisc was ok, then someone added the low latency
flag. In the current 2.6.9rc3 patch flush_to_ldisc honours
TTY_DONT_FLIP also

