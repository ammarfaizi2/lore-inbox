Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269099AbRHLLqv>; Sun, 12 Aug 2001 07:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269100AbRHLLql>; Sun, 12 Aug 2001 07:46:41 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:2573 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269099AbRHLLqh>; Sun, 12 Aug 2001 07:46:37 -0400
Subject: Re: struct page to 36 (or 64) bit bus address?
To: davem@redhat.com (David S. Miller)
Date: Sun, 12 Aug 2001 12:49:00 +0100 (BST)
Cc: sandy@storm.ca, linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "David S. Miller" at Aug 12, 2001 01:00:13 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Vtjo-0005ay-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There have been a few threads on this issue.  One of the core reasons
> the situation is unlikely to change in 2.4.x is that the scsi layer in
> it's current form makes the logic required for recovering from a DMA
> mapping failure aweful at best.

Actually its pretty trivial to resolve that I think. We already follow
precisely the right procedure for some other scsi events. So 

	scsi_retry_command(SCpnt);

would map to setting the error and returning.

