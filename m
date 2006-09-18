Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751518AbWIRN1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbWIRN1p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 09:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751523AbWIRN1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 09:27:45 -0400
Received: from nwd2mail11.analog.com ([137.71.25.57]:2685 "EHLO
	nwd2mail11.analog.com") by vger.kernel.org with ESMTP
	id S1751516AbWIRN1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 09:27:44 -0400
X-IronPort-AV: i="4.09,180,1157342400"; 
   d="scan'208"; a="9659212:sNHT29402541"
Message-Id: <6.1.1.1.0.20060918091937.01ec6eb0@ptg1.spd.analog.com>
X-Mailer: QUALCOMM Windows Eudora Version 6.1.1.1
Date: Mon, 18 Sep 2006 09:27:59 -0400
To: linux-kernel@vger.kernel.org
From: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: drivers/char/random.c exported interfaces
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It says in the comments in drivers/char/random.c that:

   * Exported interfaces ---- input
   * ==============================
   *
   * The current exported interfaces for gathering environmental noise
   * from the devices are:
   *
   * 	void add_input_randomness(unsigned int type, unsigned int code,
   *                                unsigned int value);
   * 	void add_interrupt_randomness(int irq);
   *
   * add_input_randomness() uses the input layer interrupt timing, as well as
   * the event type information from the hardware.
   *
[..snip..]

If "add_input_randomness" is an "Exported interface" why is it not an
exported symbol?

If I build drivers/input/input.ko, I get the error:

** Warning: "add_input_randomness" [drivers/input/input.ko] undefined!

?

Thanks
-Robin
