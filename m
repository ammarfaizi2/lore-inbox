Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264150AbTEaGIZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 02:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264151AbTEaGIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 02:08:25 -0400
Received: from pizda.ninka.net ([216.101.162.242]:4533 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264150AbTEaGIY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 02:08:24 -0400
Date: Fri, 30 May 2003 23:20:04 -0700 (PDT)
Message-Id: <20030530.232004.115919834.davem@redhat.com>
To: jmorris@intercode.com.au
Cc: joern@wohnheim.fh-wedel.de, dwmw2@infradead.org,
       matsunaga_kazuhisa@yahoo.co.jp, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] 1/2 central workspace for zlib
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Mutt.LNX.4.44.0305310101550.30969-100000@excalibur.intercode.com.au>
References: <20030530144959.GA4736@wohnheim.fh-wedel.de>
	<Mutt.LNX.4.44.0305310101550.30969-100000@excalibur.intercode.com.au>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: James Morris <jmorris@intercode.com.au>
   Date: Sat, 31 May 2003 01:29:42 +1000 (EST)
   
   This won't work for the bh lock protected case outlined above, and
   will cause contention between different users of zlib.

My understanding is that these are just scratchpads.  The contents
while a decompress/compress operation is not occuring does not
matter.

So if we have 2 such scratchpads per cpu, one for normal and one for
BH context, his idea truly can work and be useful to everyone.
It would also be lockless on SMP.
