Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129050AbQKIQHe>; Thu, 9 Nov 2000 11:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129100AbQKIQHY>; Thu, 9 Nov 2000 11:07:24 -0500
Received: from [62.172.234.2] ([62.172.234.2]:37999 "EHLO saturn.homenet")
	by vger.kernel.org with ESMTP id <S129050AbQKIQHS>;
	Thu, 9 Nov 2000 11:07:18 -0500
Date: Thu, 9 Nov 2000 16:07:51 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: linux-kernel@vger.kernel.org
Subject: why do we need pg1?
Message-ID: <Pine.LNX.4.21.0011091604100.1327-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The code which sets up the page table at pg0 (in head.S) goes all the way
until it hits empty_zero_page so I don't understand why we need the label
pg1 in between, since it is never referred to by any other code?

Also, is the comment in asm/pgtable.h

/* page table for 0-4MB for everybody */
extern unsigned long pg0[1024];

true or false? Isn't it for 0-8M as head.S claims?

Regards,
Tigran


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
