Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261938AbUL0R6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbUL0R6f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 12:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbUL0R6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 12:58:35 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:58011 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261938AbUL0R6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 12:58:33 -0500
Subject: Re: Linux 2.6.10-ac1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Andreas Steinmetz <ast@domdv.de>, Ross Biro <ross.biro@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <58cb370e04122707544be6d600@mail.gmail.com>
References: <1104103881.16545.2.camel@localhost.localdomain>
	 <58cb370e04122616577e1bd33@mail.gmail.com> <41CF649E.20409@domdv.de>
	 <58cb370e041226174019e75e23@mail.gmail.com>
	 <8783be660412270645717b89d1@mail.gmail.com>
	 <58cb370e0412270738fbc045c@mail.gmail.com> <41D02EEC.4090000@domdv.de>
	 <58cb370e04122707544be6d600@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104166472.20952.55.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 27 Dec 2004 16:54:33 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-12-27 at 15:54, Bartlomiej Zolnierkiewicz wrote:
> Ah, so the problem only affects native PCI IRQs.
> Is it possible that it is a buggy IDE host driver not a generic IDE problem?

More likely it is a core problem. I'm still stomping 400nS timing
violations and you don't have all of those let alone the other locking
stuff. Nor are we anywhere remotely near fixing them. Blaming the host
driver at this point seems a bit early for any IDE bug.

There certainly are corner cases where APIC timing for PIII especially
would radically change behaviour. We also exercise IRQ masking far
harder than any other driver with IDE.

Alan

