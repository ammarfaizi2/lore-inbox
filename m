Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262763AbTESW1q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 18:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263280AbTESW1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 18:27:46 -0400
Received: from pizda.ninka.net ([216.101.162.242]:3783 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262763AbTESW1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 18:27:45 -0400
Date: Mon, 19 May 2003 15:37:58 -0700 (PDT)
Message-Id: <20030519.153758.71094061.davem@redhat.com>
To: davidm@hpl.hp.com, davidm@napali.hpl.hp.com
Cc: akpm@digeo.com, ak@muc.de, arjanv@redhat.com, johnstul@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: time interpolation hooks
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <16073.5555.158600.61609@napali.hpl.hp.com>
References: <16069.24454.349874.198470@napali.hpl.hp.com>
	<1053139080.7308.6.camel@rth.ninka.net>
	<16073.5555.158600.61609@napali.hpl.hp.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@napali.hpl.hp.com>
   Date: Mon, 19 May 2003 10:34:43 -0700

   >>>>> On 16 May 2003 19:38:01 -0700, "David S. Miller" <davem@redhat.com> said:
   
     DaveM> I think Andrew is really suggesting to declare these two
     DaveM> things in an arch header, so if one needs it to be a function
     DaveM> pointer one can make it so.
   
   I don't think this should be (purely) an arch thing.  It's just as
   much a driver issue.  For example, HPET will pretty much work the same
   on x86 and ia64, so being able to have a shared "driver" would be
   useful.  I agree though that it would be nice if arches that don't
   care for time-interpolation at all could turn it off completely.
   In the proposal below, an architecture could achieve that by turning
   off CONFIG_TIME_INTERPOLATION.

That's not the issue, if I have only ONE way to do this on my
platform, I can INLINE this thing and I DO NOT need function
pointers.

I should have that option.
