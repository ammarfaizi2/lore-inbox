Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbTHTXIl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 19:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbTHTXIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 19:08:41 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:27092 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262321AbTHTXIj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 19:08:39 -0400
Date: Thu, 21 Aug 2003 01:08:12 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Ronald Bultje <rbultje@ronald.bitfreak.net>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@odsl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.0-test3 zoran driver update
Message-ID: <20030821010812.A6961@electric-eye.fr.zoreil.com>
References: <1061414594.1320.97.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1061414594.1320.97.camel@localhost.localdomain>; from rbultje@ronald.bitfreak.net on Wed, Aug 20, 2003 at 11:23:15PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ronald Bultje <rbultje@ronald.bitfreak.net> :
[...]

- {adv7170/adv7175/bt819/saa7110/saa7185}_detect_client()
  for each of these functions, two error exit path leak on locally allocated
  variable "channel".

- {adv7170/adv7175/bt819/saa7111/saa7185}_write_block()
  The code duplication could surely be avoided.

- always put a blank line between variables declaration and code pleae

- find_zr36057():
  what about replacing pci_find_device() by the modern pci insertion/removal
  api (which has been standing there for ~3 years)

- pci_enable_device() in find_zr36057() isn't balanced by pci_disable_device()
  in zoran_release()

- +irqreturn_t
  +zoran_irq (int             irq,
[...]
  +                                               for (i = 0; i < 4; i++) {
  +                                                       if (zr->
  +                                                           stat_com[i] &
  +                                                           1)
  +                                                               sv[i] =
  +                                                                   '1';
  +                                               }

  Post-modernism ?


It looks interesting.

--
Ueimor
