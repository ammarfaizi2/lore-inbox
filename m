Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264261AbTEZE4W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 00:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264262AbTEZE4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 00:56:22 -0400
Received: from pizda.ninka.net ([216.101.162.242]:36488 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264261AbTEZE4W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 00:56:22 -0400
Date: Sun, 25 May 2003 22:08:52 -0700 (PDT)
Message-Id: <20030525.220852.42800415.davem@redhat.com>
To: mika.penttila@kolumbus.fi
Cc: rmk@arm.linux.org.uk, akpm@digeo.com, hugh@veritas.com,
       LW@KARO-electronics.de, linux-kernel@vger.kernel.org
Subject: Re: [patch] cache flush bug in mm/filemap.c (all kernels >=
 2.5.30(at least))
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3ED1A0FE.3000101@kolumbus.fi>
References: <20030523193458.B4584@flint.arm.linux.org.uk>
	<1053919171.14018.2.camel@rth.ninka.net>
	<3ED1A0FE.3000101@kolumbus.fi>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: **UNKNOWN CHARSET** <mika.penttila@kolumbus.fi>
   Date: Mon, 26 May 2003 08:07:10 +0300

   I don't think the flush_dcache_page thing is done almost anywhere in the 
   block/driver level right now.

It isn't and it shouldn't :-)

   And we shouldn't be doing io reads to pagecache pages with user
   mappings anyway normally. direct-io is a different thing.
   
We are talking about the case where we are bringing in the
data for the first time, on the page cache lookup miss.
