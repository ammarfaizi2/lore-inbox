Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbTHSVSB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 17:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbTHSVR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 17:17:59 -0400
Received: from rth.ninka.net ([216.101.162.244]:45190 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S261537AbTHSVRt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 17:17:49 -0400
Date: Tue, 19 Aug 2003 14:17:35 -0700
From: "David S. Miller" <davem@redhat.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: jonsmirl@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: Standard driver call to enable/disable PCI ROM
Message-Id: <20030819141735.52ffedc7.davem@redhat.com>
In-Reply-To: <20030819215246.H23670@flint.arm.linux.org.uk>
References: <20030819210618.D23670@flint.arm.linux.org.uk>
	<20030819204643.75442.qmail@web14913.mail.yahoo.com>
	<20030819215246.H23670@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003 21:52:46 +0100
Russell King <rmk@arm.linux.org.uk> wrote:

>                 new |= res->flags & PCI_ROM_ADDRESS_ENABLE;
>                 reg = dev->rom_base_reg;

A word of caution, please do not enable PCI ROMs lightly.

There are many devices which stop responding to MEM and IO
space once their ROM is enabled, Qlogic-ISP chips are one
such device and there are several others.
