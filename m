Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbVHVXBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbVHVXBE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 19:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbVHVXBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 19:01:01 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:143 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751184AbVHVXA7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 19:00:59 -0400
Subject: Re: [PATCH 2.6.12.5 1/2] lib: allow idr to be used in irq context
From: James Bottomley <James.Bottomley@SteelEye.com>
To: luben_tuikov@adaptec.com
Cc: Andrew Morton <akpm@osdl.org>, Jim Houston <jim.houston@ccur.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Dave Jones <davej@redhat.com>, Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <20050822003325.33507.qmail@web51613.mail.yahoo.com>
References: <20050822003325.33507.qmail@web51613.mail.yahoo.com>
Content-Type: text/plain
Date: Sun, 21 Aug 2005 22:15:40 -0500
Message-Id: <1124680540.5068.37.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-08-21 at 17:33 -0700, Luben Tuikov wrote:
> No preallocation is done from IRQ context.  Do not spread FUD.
> It seems to me that you're unaware how IDR works and unaware how
> the driver works.

Argumentum ad Hominem now ... we'll get them all eventually.

Since you won't post the usage code, just answer this: how does what
you're doing with idr differ from its originally designed consumer: the
posix timers which also do the idr_remove() in IRQ context?

To me it seems your argument applies to this case as well, but you
didn't quote it when asked for an example, so I assume there's some
difference that I don't understand.

James




