Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265906AbUFOUIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265906AbUFOUIg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 16:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265911AbUFOUIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 16:08:36 -0400
Received: from mail.kroah.org ([65.200.24.183]:31369 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265906AbUFOUId (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 16:08:33 -0400
Date: Tue, 15 Jun 2004 13:06:34 -0700
From: Greg KH <greg@kroah.com>
To: Byron Stanoszek <gandalf@winds.org>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [PATCH] Make USB process hub events in correct order
Message-ID: <20040615200634.GA19411@kroah.com>
References: <Pine.LNX.4.60.0406151412430.26219@winds.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0406151412430.26219@winds.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 02:26:49PM -0400, Byron Stanoszek wrote:
> This patch fixes the USB hub module to process events in the order that they
> are received. It fixes the case where multi-port devices have multiple
> hubs in them--while they are detected in the correct order, they are
> initialized in reverse. It is required for the Sealink 8-port USB->serial 
> hubs
> to initialize with the port numbers in the correct order.
> 
> I don't think it breaks any existing functionality, but I won't send this to
> Linus yet till I know it doesn't break anything.

Linus isn't the person to send this to :)

> Patch below against 2.6.7-rc3.

You know you still can't rely on the events happening in "numerical"
order, even with this patch, right?

That's what tools like udev is for, that way you can always name your
/dev/ttyUSB* devices properly.

Anyway, I don't have a problem with this patch, other than it doesn't
apply to the current USB tree, as there has been a lot of work in the
hub driver recently.  Care to make it up again against the latest -mm
release, as that has the USB development tree included in it.

thanks,

greg k-h
