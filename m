Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265521AbUGGV4B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265521AbUGGV4B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 17:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265531AbUGGV4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 17:56:01 -0400
Received: from mail.kroah.org ([69.55.234.183]:56734 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265521AbUGGVz4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 17:55:56 -0400
Date: Wed, 7 Jul 2004 14:54:16 -0700
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jesse Stockall <stockall@magma.ca>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: (as339) Interpret down_trylock() result code correctly in usb.c
Message-ID: <20040707215416.GC4514@kroah.com>
References: <Pine.LNX.4.44L0.0407061202340.5551-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0407061202340.5551-100000@ida.rowland.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2004 at 12:11:19PM -0400, Alan Stern wrote:
> Greg:
> 
> As Andrew Morton has already spotted, I messed up the interpretation of
> the result codes from various _trylock() routines.  I didn't notice that
> down_trylock() and down_read_trylock() use opposite conventions for
> indicating success!  This patch fixes the incorrect interpretation of
> down_trylock().  That error may well be responsible for some of the
> problems cropping up recently with OHCI controllers.  Please apply.

Applied.

But even with this patch, and Andrew's, I have a hang at boot with my
USB mouse plugged in (uhci system).

thanks,

greg k-h
