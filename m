Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbTKLGmm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 01:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbTKLGml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 01:42:41 -0500
Received: from pizda.ninka.net ([216.101.162.242]:39553 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261793AbTKLGmj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 01:42:39 -0500
Date: Tue, 11 Nov 2003 22:36:30 -0800
From: "David S. Miller" <davem@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, milang@tal.org,
       linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: Linux 2.4.23-rc1
Message-Id: <20031111223630.6f2bf759.davem@redhat.com>
In-Reply-To: <20031112015433.GA20145@kroah.com>
References: <Pine.LNX.4.44.0311101723110.2001-100000@logos.cnet>
	<009001c3a89a$af611130$54dc10c3@amos>
	<002701c3a8a1$b1ce6380$54dc10c3@amos>
	<20031111145734.46d19c87.davem@redhat.com>
	<20031111231027.GC24159@parcelfarce.linux.theplanet.co.uk>
	<20031111150815.6a8aff01.davem@redhat.com>
	<20031112015433.GA20145@kroah.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Nov 2003 17:54:33 -0800
Greg KH <greg@kroah.com> wrote:

> Then how is the ir-usb driver supposed to be able to set a baud rate of
> 4000000 in a portable manner?

You just won't get support for it on Sparc, nor any other
platform that does not have the B4000000 macro defined.
Ie.

#ifdef B4000000
		case B4000000:
			....
#endif

If, some day, I figure out a clever way to encode these higher
speeds on Sparc and other platforms figure out how to do so as
well, we can remove the ifdef.

For now, the ifdef allows the thing to build properly on all
platforms.
