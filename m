Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264643AbSIWAyt>; Sun, 22 Sep 2002 20:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264650AbSIWAyt>; Sun, 22 Sep 2002 20:54:49 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:35856
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S264643AbSIWAyt>; Sun, 22 Sep 2002 20:54:49 -0400
Subject: Re: 2.5.38-mm1
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@digeo.com>
Cc: Adam Kropelin <akropel1@rochester.rr.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3D8E6647.8B02E613@digeo.com>
References: <3D8D5F2A.BC057FC4@digeo.com>
	<20020923004036.GA13921@www.kroptech.com>  <3D8E6647.8B02E613@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 22 Sep 2002 20:59:45 -0400
Message-Id: <1032742790.967.997.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-09-22 at 20:54, Andrew Morton wrote:

> It found a bug.  Someone is calling kmem_cache_create() in an
> atomic region.  Plus I think that during startup, in_atomic()
> is (probably incorrectly) returning true.

Would you mind doing a

	printk(KERN_ERR "kmem_cache_create called atomically!\n");

too?  I was confused as to what debugging check he was tripping.  Yah
yah, looking at the trace I should of known, but I didn't know you put a
check in there... :)

	Robert Love

