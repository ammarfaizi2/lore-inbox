Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261388AbSIWVAo>; Mon, 23 Sep 2002 17:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261391AbSIWVAn>; Mon, 23 Sep 2002 17:00:43 -0400
Received: from pizda.ninka.net ([216.101.162.242]:26299 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261388AbSIWVAm>;
	Mon, 23 Sep 2002 17:00:42 -0400
Date: Mon, 23 Sep 2002 13:54:47 -0700 (PDT)
Message-Id: <20020923.135447.24672280.davem@redhat.com>
To: phillips@arcor.de
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, dmo@osdl.org, axboe@suse.de,
       _deepfire@mail.ru, linux-kernel@vger.kernel.org
Subject: Re: DAC960 in 2.5.38, with new changes
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E17ta3t-0003bj-00@starship>
References: <20020923120400.A15452@acpi.pdx.osdl.net>
	<15759.26918.381273.951266@napali.hpl.hp.com>
	<E17ta3t-0003bj-00@starship>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Daniel Phillips <phillips@arcor.de>
   Date: Mon, 23 Sep 2002 22:44:08 +0200

   On Monday 23 September 2002 21:19, David Mosberger wrote:
   > This looks like a porting-nightmare in the making.  There's got to be a
   > better way to determine whether you need a writeq() vs. a writel().
   
   Even if an #ifdef is necessary here (and we are in trouble if it is) it
   should not trigger on __ia64__, it should trigger on the size of (long).

There is nothing preventing a 32-bit long platform from being able
to store 64-bits at once to PCI space.
