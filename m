Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161139AbWG1M3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161139AbWG1M3F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 08:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161140AbWG1M3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 08:29:04 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:923 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161139AbWG1M3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 08:29:03 -0400
Subject: Re: Problems with Digi Etherlite Dirver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Paul G. Allen" <pgallen@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <bd8e30a40607271402g220825a5x1617f6f4a2e14c@mail.gmail.com>
References: <bd8e30a40607271402g220825a5x1617f6f4a2e14c@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 28 Jul 2006 13:47:53 +0100
Message-Id: <1154090873.13509.109.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-07-27 am 14:02 -0700, ysgrifennodd Paul G. Allen:
> While attempting to compile the Digi Etherlite 16/32 driver on a
> server running Fedora Core 5 (2.6.17-1.2145_FC5-smp-i686), I ran
> across this error:
> 
> /usr/src/redhat/BUILD/dgrp-1.9/driver/dgrp_net_ops.c:453: error:
> 'struct tty_struct' has no member named 'flip'

Digi for some reason choose to keep their drivers out of the main tree.
You'll need to ask them for a new tar or update from the 2.6.15 and
earlier flip buffer interface to the new buffering yourself. Look at the
tty driver diffs in 2.6.15-2.6.16 and it should be fairly clear.

Alan

