Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265769AbUBBSNW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 13:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265768AbUBBSNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 13:13:22 -0500
Received: from mail.shareable.org ([81.29.64.88]:60801 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S265769AbUBBSNR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 13:13:17 -0500
Date: Mon, 2 Feb 2004 18:12:29 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Greg KH <greg@kroah.com>
Cc: Martin Schlemmer <azarah@nosferatu.za.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: module-init-tools/udev and module auto-loading
Message-ID: <20040202181229.GB28007@mail.shareable.org>
References: <1075674718.27454.17.camel@nosferatu.lan> <20040202052100.GA21753@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202052100.GA21753@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> Rusty had it correct in that you need to try to load for the type of
> module:
> 	alias eth1 tulip
> 	alias usb-controller usb-ohci
> and so on.  That's the much better way.

Shouldn't these things be autodetected?

"alias usb-controller" is a poor example.  Shouldn't the kernel
automatically load drivers for all USB controllers that are found?
(On my system, there's more than one type, which makes "alias
usb-controller" even uglier).

"alias eth1" may be necessary to bind discovered NICs with the right
interface names, but it's unfortunate.  One system where I had "alias
eth0 ..."  failed to boot after a kernel upgrade when the named driver
no longer supported that network card (a different driver took over
support).

-- Jamie
