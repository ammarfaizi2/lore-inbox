Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279156AbRJ2KuF>; Mon, 29 Oct 2001 05:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279157AbRJ2Ktz>; Mon, 29 Oct 2001 05:49:55 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2564 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279156AbRJ2Ktq>; Mon, 29 Oct 2001 05:49:46 -0500
Subject: Re: Linux 2.4.13-ac4
To: vojtech@suse.cz (Vojtech Pavlik)
Date: Mon, 29 Oct 2001 10:56:35 +0000 (GMT)
Cc: laughing@shared-source.org (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20011029084736.A3152@suse.cz> from "Vojtech Pavlik" at Oct 29, 2001 08:47:36 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15yA5r-0002Ha-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> bytes read from the 8254 get swapped. I've got some indirect evidence
> that this also could happen with the original i8254. 

Im hoping not. That would imply we interrupted someone half way through
reading the counter which means the locking is screwed up.

> By the way, if we made the 8254 accesses (spinlock?) protected (which
> should be done anyway, right now definitely more than one CPU can access
> the registers at once), I think we could remove the outb(0, 0x43);,
> saving some cycles.

Some chipsets need the outb
