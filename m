Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265433AbUBAU4r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 15:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265435AbUBAU4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 15:56:47 -0500
Received: from pop.gmx.net ([213.165.64.20]:42733 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265433AbUBAU4q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 15:56:46 -0500
X-Authenticated: #222435
Date: Sun, 1 Feb 2004 21:57:21 +0100
From: Jonas Diemer <diemer@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Which interface: sysfs, proc, devfs?
Message-Id: <20040201215721.737ef5a3.diemer@gmx.de>
In-Reply-To: <20040129230250.GA9988@kroah.com>
References: <20040129222813.3b22b2c8.diemer@gmx.de>
	<20040129230250.GA9988@kroah.com>
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jan 2004 15:02:50 -0800
Greg KH <greg@kroah.com> wrote:

> What about not writing a kernel driver at all and just using
> libusb/usbfs?  Any reason you have to have a kernel driver for your
> device?


Well, I have just looked into libusb 0.1.x... I would like to have
asynchronous (non-blocking) access to my device, which libusb doesn't
currently support. Also I don't like the way libusb finds devices -
manually scanning all busses doesn't seem very handy.

Thus I will probably go for a kernel module, using sysfs to interface
with the user. Thanks for all the help anyways-

regards
Jonas
