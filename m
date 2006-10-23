Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751889AbWJWKiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889AbWJWKiA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 06:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751888AbWJWKiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 06:38:00 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43193 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751889AbWJWKh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 06:37:59 -0400
Subject: Re: incorrect taint of ndiswrapper
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Giridhar Pemmasani <pgiri@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061023054119.75745.qmail@web32415.mail.mud.yahoo.com>
References: <20061023054119.75745.qmail@web32415.mail.mud.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 23 Oct 2006 11:41:04 +0100
Message-Id: <1161600064.19388.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-10-22 am 22:41 -0700, ysgrifennodd Giridhar Pemmasani:
> Note that when a driver is loaded, ndiswrapper does taint the kernel (to be
> more accurate, it should check if the driver being loaded is GPL or not, but
> that is not done).

However by then it has already dynamically linked with explicit GPLONLY
symbols so it cannot then load a binary windows driver but should unload
itself or refuse to load anything but the GPL ndis drivers (of which
afaik only one exists), and even then they expect an environment
incompatible with the Linux kernel.


