Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262139AbVBQNLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbVBQNLG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 08:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262146AbVBQNLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 08:11:06 -0500
Received: from zork.zork.net ([64.81.246.102]:16773 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S262139AbVBQNLC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 08:11:02 -0500
From: Sean Neakums <sneakums@zork.net>
To: Davide Rossetti <davide.rossetti@roma1.infn.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rmmod while module is in use
References: <4214926B.3030707@roma1.infn.it>
Mail-Followup-To: Davide Rossetti <davide.rossetti@roma1.infn.it>,
	linux-kernel@vger.kernel.org
Date: Thu, 17 Feb 2005 13:11:00 +0000
In-Reply-To: <4214926B.3030707@roma1.infn.it> (Davide Rossetti's message of
	"Thu, 17 Feb 2005 13:47:39 +0100")
Message-ID: <6uacq35o2j.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Rossetti <davide.rossetti@roma1.infn.it> writes:

> maybe RTFM...
> a module:
> - char device driver for..
> - a PCI device

Setting the 'owner' field of your char device's file_operations
structure to THIS_MODULE should be sufficient to enable the kernel to
manage the reference count for you.  This is the "magic" referred to
in linux-os's reply.
