Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030314AbVKHSyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030314AbVKHSyE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 13:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbVKHSyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 13:54:03 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:41884
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1030314AbVKHSyA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 13:54:00 -0500
Subject: Re: [PATCH 06/25] mtd: move ioctl32 code to mtdchar.c
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: "Eric W. Biederman" <ebiederman@lnxi.com>, linux-mtd@lists.infradead.org,
       dwmw2@infradead.org, linux-kernel@vger.kernel.org,
       Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>
In-Reply-To: <20051108183339.GB31446@wohnheim.fh-wedel.de>
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com>
	 <20051105162712.921102000@b551138y.boeblingen.de.ibm.com>
	 <20051108105923.GA31446@wohnheim.fh-wedel.de>
	 <m3zmofovsc.fsf@maxwell.lnxi.com>
	 <20051108183339.GB31446@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1
Organization: linutronix
Date: Tue, 08 Nov 2005 19:57:49 +0100
Message-Id: <1131476269.18108.195.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-08 at 19:33 +0100, Jörn Engel wrote:

> Can you name a few examples, where mtdchar.c makes sense?  I've found
> it to be quite useless.

How do you access FLASH specific functionality otherwise ?

case MEMGETINFO:
....
case OTPLOCK:

It may be useless for you, but I doubt that you represent the majority
of the MTD user base. Using a RAM simulator is a bit different to the
usage of _real_ FLASH.

Look into mtd/utils and figure yourself why it _is_ useful.

The code _is_ ugly and ioctls are out of fashion, but your "remove it"
request is just silly as long as you dont provide a reasonable
alternative access to those bits.


	tglx


