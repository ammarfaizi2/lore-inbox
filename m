Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292956AbSCDWfq>; Mon, 4 Mar 2002 17:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292952AbSCDWfi>; Mon, 4 Mar 2002 17:35:38 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:43019 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292956AbSCDWfS>; Mon, 4 Mar 2002 17:35:18 -0500
Subject: Re: [RFC] Arch option to touch newly allocated pages
To: jdike@karaya.com (Jeff Dike)
Date: Mon, 4 Mar 2002 22:49:58 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <200203042046.PAA04125@ccure.karaya.com> from "Jeff Dike" at Mar 04, 2002 03:46:07 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16i1HK-0000se-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, when something calls alloc_pages and gets back some pages, it's almost
> always going to modify them immediately, right?

Yes. Which is why we don't allocate the when you map an object or create
a shmem fs file

> If this is true, then what I'm proposing would force the host to find backing
> memory for those pages a tiny bit earlier than it would have had to otherwise.

In the normal case about half of the pages are never allocated that are
mapped. In other words no alloc_pages was ever done for them or will ever
be needed. 

