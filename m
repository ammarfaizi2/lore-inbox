Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRAMWqU>; Sat, 13 Jan 2001 17:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129725AbRAMWqK>; Sat, 13 Jan 2001 17:46:10 -0500
Received: from james.kalifornia.com ([208.179.0.2]:53599 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S129401AbRAMWpx>; Sat, 13 Jan 2001 17:45:53 -0500
Message-ID: <3A60DA9C.19A2B13A@linux.com>
Date: Sat, 13 Jan 2001 14:45:49 -0800
From: David Ford <david@linux.com>
Reply-To: david+validemail@kalifornia.com
Organization: Talon Technology, Intl.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Santinoli <u235@libero.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: BUG in 2.4.0: dd if=/dev/random of=out.txt bs=10000 count=100
In-Reply-To: <20010113035314.316.qmail@web5205.mail.yahoo.com> <20010113213728.B790@aidi.santinoli.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Santinoli wrote:

> On Fri, Jan 12, 2001 at 07:53:14PM -0800, Rob Landley wrote:
> > If I do the dd line in the title under 2.4.0 I get an
> > out.txt file of 591 bytes.
> And it's the same under 2.2.x, too.
>
> > dd says it completes happily even when copying from
> > random.  0+100 records in, 0+100 records out.  It
> It's not a fault of dd, or of the read() system call, either. It's just the way
> /dev/random works - you can't read more bytes than those available in the
> entropy pool. And if you try, you'll just fail with no error.

It won't fail, it will block, then continue reading when more bytes are
available.  The application may time out however.

-d

-- ---NOTICE

-- fwd: fwd: fwd: type emails will be deleted automatically.
      "There is a natural aristocracy among men. The grounds of this are
      virtue and talents", Thomas Jefferson [1742-1826], 3rd US President



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
