Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268066AbUHSGQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268066AbUHSGQn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 02:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265999AbUHSGQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 02:16:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10720 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265996AbUHSGQj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 02:16:39 -0400
Date: Wed, 18 Aug 2004 23:16:24 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-usb-devel@lists.sourceforge.net>,
       <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH][linux-usb-devel] Early USB handoff
Message-Id: <20040818231624.414673c3@lembas.zaitcev.lan>
In-Reply-To: <5F106036E3D97448B673ED7AA8B2B6B3015B698A@scl-exch2k.phoenix.com>
References: <5F106036E3D97448B673ED7AA8B2B6B3015B698A@scl-exch2k.phoenix.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Aug 2004 19:09:53 -0700
"Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com> wrote:

> Attached is a patch for 2.6.8.1

This looks good, however I'd like you to make spacing more kernel-like,
for example here:

> +			writel( 0x3f, op_reg_base + EHCI_USBSTS);
> +			udelay( delta);

Also, the double star has to go:

 /**
  * foo
  */

It might confuse scripts which generate Docbook manuals.

Once you're done, we only have to wait for Greg to get back from
vacation, pipe through him into -mm and have someone actually
testing it on the IBM's Itanium NUMA for confirmation that it
actually worked. Only then Linus will take it, and I'll take it
for Marcelo. Kind of long way, but there you have it...
I'll feed it to Dell people too, I know they suffered from it.

BTW, why is that you awarded EHCI its own function, but not UHCI or OHCI?

-- Pete
