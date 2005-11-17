Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161058AbVKQAsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161058AbVKQAsE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 19:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161057AbVKQAsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 19:48:04 -0500
Received: from mail.kroah.org ([69.55.234.183]:40917 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161060AbVKQAsD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 19:48:03 -0500
Date: Wed, 16 Nov 2005 16:30:53 -0800
From: Greg KH <gregkh@suse.de>
To: linux-usb-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 00/02] [RFC] Add dynamic id support to all USB drivers
Message-ID: <20051117003053.GA14896@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's two patches against the latest -git tree that add the ability to
add new vendor/product device id pairs to USB drivers after they have
been loaded.  It works just like the PCI drivers do, with the exception
that only vendor/product can be specified (no class stuff.)  I did it
this way to make it simpler, as that's almost all anyone ever wants to
add.

Note that usb-serial drivers do not work properly with these dynamic ids
yet, it's going to take some rework of the usb-serial core due to the
wierd way it binds drivers to devices to get this to work properly.

Comments?

thanks,

greg k-h
