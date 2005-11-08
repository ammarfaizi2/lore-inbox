Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030316AbVKHTDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030316AbVKHTDp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 14:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030321AbVKHTDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 14:03:44 -0500
Received: from baythorne.infradead.org ([81.187.2.161]:33495 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S1030316AbVKHTDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 14:03:44 -0500
Subject: Re: [PATCH 06/25] mtd: move ioctl32 code to mtdchar.c
From: David Woodhouse <dwmw2@infradead.org>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: "Eric W. Biederman" <ebiederman@lnxi.com>, Arnd Bergmann <arnd@arndb.de>,
       linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@lst.de>
In-Reply-To: <20051108183339.GB31446@wohnheim.fh-wedel.de>
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com>
	 <20051105162712.921102000@b551138y.boeblingen.de.ibm.com>
	 <20051108105923.GA31446@wohnheim.fh-wedel.de>
	 <m3zmofovsc.fsf@maxwell.lnxi.com>
	 <20051108183339.GB31446@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Nov 2005 19:03:24 +0000
Message-Id: <1131476604.27347.115.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-08 at 19:33 +0100, Jörn Engel wrote:
> mtdblock.c, while being quite a bit more complicated, does not require
> a ton of ioctls, will not confuse users with minor number 7 actually
> being device number 3 and magically being read-only despite unix
> permissions and hardware properties. 

MAKEDEV and the documentation and udev ought to be perfectly sufficient
to deal with the slight inconvenience caused by the use of minor
numbers. The protection afforded by the read-only devices has its uses.

> Can you name a few examples, where mtdchar.c makes sense?  I've found
> it to be quite useless.

mtdchar allows you to explicitly control erases and per-byte writes. You
can't do that with mtdblock. And you might not even want CONFIG_BLK_DEV
enabled.

-- 
dwmw2


