Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264870AbUEJQxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264870AbUEJQxA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 12:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264872AbUEJQw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 12:52:59 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:46024 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S264870AbUEJQw5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 12:52:57 -0400
Subject: Re: [PATCH] hci-usb bugfix
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Sebastian Schmidt <yath@yath.eu.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200405101836.35239.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0405101211350.669-100000@ida.rowland.org>
	 <1084205974.9639.16.camel@pegasus>  <200405101836.35239.oliver@neukum.org>
Content-Type: text/plain
Message-Id: <1084207959.9639.23.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 10 May 2004 18:52:39 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

> > > It looks like the problem is that hci_usb_disconnect() is trying to do too 
> > > much.  When called for the SCO interface it should simply return.
> > 
> > I came to the same conclusion, but I used the attached patch.
> 
> Which is wrong. It assumes that interfaces are disconnected in a certain
> order, which happens only by chance in your case.

why is it wrong? If interface 0 is disconnected first then we go into
the disconnect routine and cleanup. But if interface 1 is disconnected
first, we don't do anything and "wait" for the disconnect on first
interface.

Regards

Marcel


