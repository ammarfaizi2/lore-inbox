Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751044AbWJLV0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbWJLV0g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 17:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbWJLV0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 17:26:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25016 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751010AbWJLV0f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 17:26:35 -0400
Date: Thu, 12 Oct 2006 14:26:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, Don Mullis <dwm@meer.net>
Subject: Re: [patch 0/7] fault-injection capabilities (v5)
Message-Id: <20061012142625.520d3d87.akpm@osdl.org>
In-Reply-To: <452df20e.025ef312.44f0.7578@mx.google.com>
References: <452df20e.025ef312.44f0.7578@mx.google.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2006 16:43:05 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> Fault-injection capabilities patch set version 5.

It all looks quite nice, thanks.  Couple of things...

You've presumably run a kernel with these various things enabled.  What
happens?  Does the kernel run really slowly?  Does userspace collapse in a
heap?  Does it oops and die?

Also, one place where this infrastructure could be of benefit is in device
drivers: simulate a bad sector on the disk, a pulled cable, a timeout
reading from a status register, etc.  If that works well and is useful then
I can see us encouraging driver developers to wire up fault-injection in
the major drivers.

Hence it would be useful at some stage to go in and to actually do all this
for a particular driver.  As an example implementation for others to
emulate and as a test for the fault-injection infrastructure itself - we
may discover that new capabilities are needed as this work is done.

I wouldn't say this is an urgent thing to be doing, but it is a logical
next step..

