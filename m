Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131493AbRCWWh1>; Fri, 23 Mar 2001 17:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131494AbRCWWgI>; Fri, 23 Mar 2001 17:36:08 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:12049 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131489AbRCWWdr>; Fri, 23 Mar 2001 17:33:47 -0500
Subject: Re: [PATCH] Fix races in 2.4.2-ac22 SysV shared memory
To: torvalds@transmeta.com (Linus Torvalds)
Date: Fri, 23 Mar 2001 22:35:21 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), sct@redhat.com (Stephen C. Tweedie),
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bcrl@redhat.com (Ben LaHaise), cr@sap.com (Christoph Rohland)
In-Reply-To: <Pine.LNX.4.31.0103231424230.766-100000@penguin.transmeta.com> from "Linus Torvalds" at Mar 23, 2001 02:27:12 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14ga9U-0005aa-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you don't want to sleep, you need to use one of the wrappers for
> "__find_page_nolock()". Something like "find_get_page()", which only
> "gets" the page.

 * a rather lightweight function, finding and getting a reference to a
 * hashed page atomically, waiting for it if it's locked.

__find_get_page has I think a misleading comment ?

> The naming actually does make sense in this area.

Yep

