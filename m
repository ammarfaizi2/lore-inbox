Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263953AbTI2RlP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263940AbTI2Rhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:37:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:59800 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263926AbTI2RfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:35:23 -0400
Date: Mon, 29 Sep 2003 10:27:25 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Shine Mohamed <shinemohamed_j@naturesoft.net>
Cc: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Initializedd the module parameters in
 drivers/net/wireless/arlan-main.c
Message-Id: <20030929102725.796f2259.rddunlap@osdl.org>
In-Reply-To: <200309291644.06043.shinemohamed_j@naturesoft.net>
References: <200309291644.06043.shinemohamed_j@naturesoft.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Sep 2003 16:44:06 +0530 Shine Mohamed <shinemohamed_j@naturesoft.net> wrote:

| Quick patch to  Initialize  the module parameters in 
| drivers/net/wireless/arlan-main.c
| 
| 
| --- drivers/net/wireless/arlan-main.c.orig      2003-09-29 16:40:33.000000000 
| +0530
| +++ drivers/net/wireless/arlan-main.c   2003-09-29 16:40:18.000000000 +0530
| @@ -33,6 +33,7 @@
|  static int retries = 5;
|  static int tx_queue_len = 1;
|  static int arlan_EEPROM_bad;
| +static int probe = 0; /* Initially it is setting to be 'Probing Disabled' */

Yes, it does need to be declared, but it doesn't need to be init
to 0.

--
~Randy
