Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129806AbRAMUjm>; Sat, 13 Jan 2001 15:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129595AbRAMUjc>; Sat, 13 Jan 2001 15:39:32 -0500
Received: from libra.cyb.it ([212.11.95.209]:22800 "EHLO relay2.flashnet.it")
	by vger.kernel.org with ESMTP id <S132226AbRAMUjQ>;
	Sat, 13 Jan 2001 15:39:16 -0500
Date: Sat, 13 Jan 2001 21:37:28 +0100
From: David Santinoli <u235@libero.it>
To: linux-kernel@vger.kernel.org
Subject: Re: BUG in 2.4.0: dd if=/dev/random of=out.txt bs=10000 count=100
Message-ID: <20010113213728.B790@aidi.santinoli.com>
In-Reply-To: <20010113035314.316.qmail@web5205.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010113035314.316.qmail@web5205.mail.yahoo.com>; from telomerase@yahoo.com on Fri, Jan 12, 2001 at 07:53:14PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2001 at 07:53:14PM -0800, Rob Landley wrote:
> If I do the dd line in the title under 2.4.0 I get an
> out.txt file of 591 bytes.
And it's the same under 2.2.x, too.

> dd says it completes happily even when copying from
> random.  0+100 records in, 0+100 records out.  It
It's not a fault of dd, or of the read() system call, either. It's just the way
/dev/random works - you can't read more bytes than those available in the
entropy pool. And if you try, you'll just fail with no error.

Cheers,
 David
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
