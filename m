Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264675AbRFQBWU>; Sat, 16 Jun 2001 21:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264676AbRFQBWJ>; Sat, 16 Jun 2001 21:22:09 -0400
Received: from tomts8.bellnexxia.net ([209.226.175.52]:8144 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S264675AbRFQBWD>; Sat, 16 Jun 2001 21:22:03 -0400
To: linux-kernel@vger.kernel.org
Subject: Newbie idiotic questions.
From: Bill Pringlemeir <bpringle@sympatico.ca>
Date: 16 Jun 2001 21:19:47 -0400
Message-ID: <m2d78352do.fsf@sympatico.ca>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have been looking at the emu10k1 driver and I had a few questions
about general idioms used there.

In a line like this,

[main.c, line 175]

	for (count = 0; count < sizeof(card->digmix) / sizeof(card->digmix[0]); count++) {

Isn't there some sort of `ALEN' macro available, or is this
considered to muddy things by using a macro?

[main.c, line 223]
	if ((card->mpuout = kmalloc(sizeof(struct emu10k1_mpuout), GFP_KERNEL))

Why is the struct type referenced for the allocation size?  Why not,

	if ((card->mpuout = kmalloc(sizeof(card->mpuout), GFP_KERNEL))

This seems to get the size for the actual object being allocated.

[cardmi.c, line 42]

static struct {
	int (*Fn) (struct emu10k1_mpuin *, u8);
} midistatefn[] = {
...

Why aren't all the gobs of constant data in this driver declared as
constant?  Do it give a performance advantage by having the data in a
different MMU section and better cache effects or something?

Thanks for any helpful pointers.  I did read the FAQ.  I am just
wonder if I would get screamed at for changing things like this and
why... so I will probably get yelled at for suggesting them anyway,
but at least I won't have went through the effort.  Now that I have
pointed that out, the will probably irk people even more...

regards,
Bill Pringlemeir.


