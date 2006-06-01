Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030239AbWFAQzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030239AbWFAQzI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 12:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbWFAQzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 12:55:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9708 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030239AbWFAQzG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 12:55:06 -0400
Date: Thu, 1 Jun 2006 09:59:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: liontooth@cogweb.net, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: USB devices fail unnecessarily on unpowered hubs
Message-Id: <20060601095913.06200806.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0606011050330.6784-100000@iolanthe.rowland.org>
References: <20060601030140.172239b0.akpm@osdl.org>
	<Pine.LNX.4.44L0.0606011050330.6784-100000@iolanthe.rowland.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jun 2006 10:58:43 -0400 (EDT)
Alan Stern <stern@rowland.harvard.edu> wrote:

> As an alternative, we could allow an "over-budget window" of say 10%.  

That, plus we should provide a suitable i-know-what-im-doing user override,
with the appropriate warnings, as well as a printk which directs users to
this option when we decided to disable their device.

> Configurations that exceed the power budget by less than that amount would
> still be accepted.  I don't know whether this would be enough of a help,
> however.  I've heard of devices that claim to require 200 mA, for
> instance.  It just doesn't seem right to enable them when the upstream hub
> can only provide 100 mA.

The power supply spec is a conservative minimum, whereas the device spec is
a worst-case maximum.  One would expect a lot of devices will work OK when
run "out of spec".

(Goes away and pats all his 240V plugpacks which are happily working off 110V).

