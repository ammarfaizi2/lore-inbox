Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbWGLBTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbWGLBTV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 21:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWGLBTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 21:19:21 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:62870
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932341AbWGLBTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 21:19:20 -0400
Date: Tue, 11 Jul 2006 18:19:51 -0700 (PDT)
Message-Id: <20060711.181951.56872620.davem@davemloft.net>
To: jketreno@linux.intel.com
Cc: alan@lxorguk.ukuu.org.uk, alon.barlev@gmail.com, s0348365@sms.ed.ac.uk,
       linville@tuxdriver.com, joesmidt@byu.net, linux-kernel@vger.kernel.org
Subject: Re: Will there be Intel Wireless 3945ABG support?
From: David Miller <davem@davemloft.net>
In-Reply-To: <44B443E4.1000707@linux.intel.com>
References: <44B3ED29.4040801@gmail.com>
	<1152644119.18028.46.camel@localhost.localdomain>
	<44B443E4.1000707@linux.intel.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Ketrenos <jketreno@linux.intel.com>
Date: Tue, 11 Jul 2006 17:35:48 -0700

> The obvious distinction between scsi firmware and the regulatory
> daemon blob being discussed here is that the regulatory daemon runs
> on the host vs. an adapter.  However, if you consider the
> communication interface between the kernel and the user space daemon
> to be analogous to the communication interface between the kernel
> driver and the firmware that runs on an adapter, then the
> distinction of running on the host is irrelevant.

The core issue is whether the userland blob could stand alone and is
something that could exist independant of Linux and the kernel side
GPL'd driver.

Difficult areas arise when you design a set of interfaces specifically
to talk to the binary blob, and which exist for no other purpose and
do not provide some well defined "standard" API such as the SCSI
command set, as an example.  It is just a backdoor into the binary
blob, and therefore this could make it more likely to be considered
a derivative work.

Firmware that runs on the card is also a tricky area, and not everyone
agrees on that issue as well.

Unfortunately, none of this is fun stuff :-/
