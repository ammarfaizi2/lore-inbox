Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267999AbUHPWvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267999AbUHPWvq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 18:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268006AbUHPWvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 18:51:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39572 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267999AbUHPWvo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 18:51:44 -0400
Date: Mon, 16 Aug 2004 15:48:15 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-usb-devel@lists.sourceforge.net>,
       <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH][linux-usb-devel] Early USB handoff
Message-Id: <20040816154815.3f0856d4@lembas.zaitcev.lan>
In-Reply-To: <5F106036E3D97448B673ED7AA8B2B6B3015B68E6@scl-exch2k.phoenix.com>
References: <5F106036E3D97448B673ED7AA8B2B6B3015B68E6@scl-exch2k.phoenix.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Aug 2004 13:06:17 -0700
"Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com> wrote:

>   Here is slightly improved early USB legacy handoff patch for 2.4.27

The usual caveat is how we all wait for this to go into 2.6.

>   I've tested it on a number of machines (mostly laptops) for UHCI &
> OHCI, but PC with EHCI BIOS legacy support was hard to find. I tried
> Intel D865GRH, but seems like BIOS there have some problems (like lock
> up during POST when flash drive plugged in), and does not adhere EHCI
> handoff protocol.

That part looked ok. Such computers are semi-popular. Our QA department
has Thinkpads with similarly broken BIOS. I'm glad you did not decide
to call panic() in such case :-)

>   Handoff is under no-usb-legacy option.
> +int disable_legacy_usb __initdata = 0;

I think it's an unfortunate naming. When I was reading the patch, I got
the meaning exactly backwards. I think that we should not be afraid
of using something like "do handoff" or "do NOT do a handoff" in the
documentation and flag names, for extra clarity.

-- Pete
