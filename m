Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265106AbUGBXsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265106AbUGBXsv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 19:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265107AbUGBXsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 19:48:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:2783 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265106AbUGBXsu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 19:48:50 -0400
Date: Fri, 2 Jul 2004 16:51:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Osterlund <petero2@telia.com>
Cc: greg@kroah.com, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: [PATCH] CDRW packet writing support for 2.6.7-bk13
Message-Id: <20040702165132.575cba5b.akpm@osdl.org>
In-Reply-To: <m27jtm0z7q.fsf@telia.com>
References: <m2lli36ec9.fsf@telia.com>
	<m2u0wqqdpl.fsf@telia.com>
	<20040702150819.646b6103.akpm@osdl.org>
	<20040702224720.GA7969@kroah.com>
	<20040702155945.5c375bd2.akpm@osdl.org>
	<m27jtm0z7q.fsf@telia.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> wrote:
>
> > Oop, sorry, yes.  Peter, are you sure this is where the leak is coming from?
> 
> I'm sure that the module reference count as reported by lsmod
> increases each time I access /proc/driver/pktcdvd/pktcdvd0. I can make
> this problem go away either by patching __bdevname() or by deleting
> the call to __bdevname() in pktcdvd.c.

Can't you use bdevname(pd->bdev) in there?
