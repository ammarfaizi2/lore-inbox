Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129306AbRBMBMd>; Mon, 12 Feb 2001 20:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129850AbRBMBMX>; Mon, 12 Feb 2001 20:12:23 -0500
Received: from mpoli.fi ([62.236.132.1]:53265 "EHLO mpoli.fi")
	by vger.kernel.org with ESMTP id <S129306AbRBMBMQ>;
	Mon, 12 Feb 2001 20:12:16 -0500
Date: Tue, 13 Feb 2001 03:07:16 +0200
From: Olli Lounela <olli@mpoli.fi>
To: "Leonard N. Zubkoff" <lnz@dandelion.com>
Cc: linux-kernel@vger.kernel.org, support@mylex.com
Subject: Re: fwd: Mylex dac960 not SMP-safe?
Message-ID: <20010213030716.A31697@mpoli.fi>
Reply-To: olli@mpoli.fi
In-Reply-To: <20010212134757.A18423@mpoli.fi> <200102121702.f1CH20U03841@dandelion.com> <20010213015501.J17002@mpoli.fi> <20010213022806.A31582@mpoli.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <20010213022806.A31582@mpoli.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2001 at 02:28:06AM +0200, Olli Lounela wrote:
>
> Okay, I goofed. The motherboard reset the interrupts to the same old stoopid
> values when I shuffled the cards. I have now separated them, no difference.

Progress: not only did I goof, I was wrong too.

This time it booted once the network timed out, but the eepro is not
functioning properly; it seems unable to receive. I can see it sends alright
from the dhcpserver log.

IRQ's are now

   Mylex    10
   aic7880  17
   eepro    18
   VGA      19

Mylex still hangs without nosmp. IRQ routing problem in APIC initialization,
maybe?

Darn this old piece of junk is slow to boot...

-- 
    Olli               ...and he thought I'm serious! Hahahaha...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
