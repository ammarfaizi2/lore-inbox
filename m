Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129091AbQKWTX0>; Thu, 23 Nov 2000 14:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129097AbQKWTXQ>; Thu, 23 Nov 2000 14:23:16 -0500
Received: from 213-120-138-133.btconnect.com ([213.120.138.133]:60169 "EHLO
        penguin.homenet") by vger.kernel.org with ESMTP id <S129091AbQKWTXD>;
        Thu, 23 Nov 2000 14:23:03 -0500
Date: Thu, 23 Nov 2000 18:54:48 +0000 (GMT)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
To: linux-kernel@vger.kernel.org
Subject: alloc_tty_struct() question.
Message-ID: <Pine.LNX.4.21.0011231852590.2128-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The sizeof(struct tty_struct) = 3084. Why don't we have a private slab
cache for it instead of getting a page and wasting some precious bytes at
the end? Potentially, we can have thousands of tty_struct allocated
(assuming we have thousands of concurrent users)...

regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
