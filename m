Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263079AbUDSGJf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 02:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263304AbUDSGJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 02:09:34 -0400
Received: from gate.crashing.org ([63.228.1.57]:10910 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263079AbUDSGJc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 02:09:32 -0400
Subject: Re: usb and preempt oopses with 2.6.6-rc1 on ppc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1082354034.1717.8.camel@localhost>
References: <1082354034.1717.8.camel@localhost>
Content-Type: text/plain
Message-Id: <1082354963.1677.11.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 19 Apr 2004 16:09:24 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-04-19 at 15:53, Soeren Sonnenburg wrote:
> Hi.
> 
> I get the following 2 oopses with the 2.6.6-rc1 kernel on my G4 powerbook.
> The first one is an usb oops (from 2.6.5) and the second one probably a preempt issue on ppc.

The first one is probably an existing USB / bluetooth problem that
you should report to the appropriate list

> This is the usb oops I get when I don't hciconfig hci0 down and stop all
> blue-* programs before *REMOVING* the bluetooth dongle.

The second one looks like a VM bug actually. I spotted a patch going
to Linus tree today fixing vma corruption, could be related...

Ben


