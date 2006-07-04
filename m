Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbWGDUy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbWGDUy4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 16:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWGDUy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 16:54:56 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:11669 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S932257AbWGDUyz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 16:54:55 -0400
Message-ID: <44AAD59E.7010206@drzeus.cx>
Date: Tue, 04 Jul 2006 22:54:54 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: resource_size_t and printk()
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there!

Your commit b60ba8343b78b182c03cf239d4342785376c1ad1 has been causing me
a bit of confusion and I thought I'd point out the problem so that you
can resolve it. :)

resource_size_t is not guaranteed to be a long long, but might be a u64
or u32 depending on your .config. So you need an explicit cast in the
printk:s or you get a lot of junk on the output.

There might be other commits with the same issue. I just noticed this one.

Rgds
Pierre
