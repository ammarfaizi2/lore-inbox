Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136491AbRAMDxh>; Fri, 12 Jan 2001 22:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136490AbRAMDx0>; Fri, 12 Jan 2001 22:53:26 -0500
Received: from web5205.mail.yahoo.com ([216.115.106.86]:56072 "HELO
	web5205.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S135954AbRAMDxP>; Fri, 12 Jan 2001 22:53:15 -0500
Message-ID: <20010113035314.316.qmail@web5205.mail.yahoo.com>
Date: Fri, 12 Jan 2001 19:53:14 -0800 (PST)
From: Rob Landley <telomerase@yahoo.com>
Subject: BUG in 2.4.0: dd if=/dev/random of=out.txt bs=10000 count=100
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I do the dd line in the title under 2.4.0 I get an
out.txt file of 591 bytes.

If I do the same thing from /dev/zero, I get the
expected 1,000,000 byte file.

I've shoehorned 2.4.0 into a fresh red hat 7.0 install
which could quite easily be a bad thing, yes ripped
out their strange gcc and symlinked kgcc->gcc to do
the compile.  But other than this it seems to be
working.  (So far...)

dd says it completes happily even when copying from
random.  0+100 records in, 0+100 records out.  It
takes about thirty seconds to finish on the dual
gigahertz processor intel box I'm using to test it,
which implies it's actually performing the truly
impressive waste of CPU cycles I'm requesting from it.
 I'm just not getting the data in my file.

Am I doing something wrong?

My dd is from fileutils-4.0x-3.  (Straight Red Hat
7.0, I think...)  Didn't see anything about that in
Documentation/Changes...

I'll be happy to try one of the prepatches if anybody
thinks they've addressed this problem already.

Anybody?  Need more debugging info?  Want me to wave a
dead chicken at something specific?  Stick printk's
into the kernel?...

Rob

__________________________________________________
Do You Yahoo!?
Get email at your own domain with Yahoo! Mail. 
http://personal.mail.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
