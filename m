Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030355AbWHOPel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030355AbWHOPel (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 11:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030354AbWHOPek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 11:34:40 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43747 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030352AbWHOPei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 11:34:38 -0400
Subject: Re: What determines which interrupts are shared under Linux?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Roger Heflin <rheflin@atipa.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
In-Reply-To: <44E1E719.6020005@atipa.com>
References: <44E1D760.6070600@atipa.com>
	 <1155654379.24077.286.camel@localhost.localdomain>
	 <44E1E719.6020005@atipa.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 15 Aug 2006 16:55:16 +0100
Message-Id: <1155657316.24077.293.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-08-15 am 10:24 -0500, ysgrifennodd Roger Heflin:

> I am currently retesting under 2.6.17.8 to see if I have similar issues
> there, under that it show interrupts like below, different interrupt 
> numbers,
> but similar sharing as ata1/ata2, and ata3/ata4 are on the same interrupt.

Thats what I would expect to see - two channels per PCI device is the
normal layout and they will always share the IRQ.

