Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315988AbSHFWYP>; Tue, 6 Aug 2002 18:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316135AbSHFWYP>; Tue, 6 Aug 2002 18:24:15 -0400
Received: from hera.cwi.nl ([192.16.191.8]:59903 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S315988AbSHFWYO>;
	Tue, 6 Aug 2002 18:24:14 -0400
From: Andries.Brouwer@cwi.nl
Date: Wed, 7 Aug 2002 00:27:46 +0200 (MEST)
Message-Id: <UTC200208062227.g76MRk407059.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [bug, 2.5.29, IDE] partition table corruption?
Cc: dalecki@evision.ag
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar writes:

> using 2.5.29 (vanilla or BK-curr) i cannot use /sbin/lilo anymore
> to update the partition table.

> if i do it then the partition table gets corrupted and the system
> does not boot - it stops at 'LI'.

The standard explanation is that LILO cannot find the second stage
loader, like you say, and that happens because it looks in the wrong
place. For example, because it stores CHS coordinates in the wrong
geometry. (But it can also happen because something changed in the
disk numbering.)

"Corruption" of the partition table is to be expected only if you
ask LILO to rewrite the (CHS part of) the partition table.

The funny thing is, I removed some stuff here in 2.5.30,
so I would understand things immediately if you reported this
about 2.5.30. But for 2.5.29 I do not immediately see why
you would see any changes.

Did you in the meantime find out what was wrong?

Are things OK in 2.5.28 and wrong in vanilla 2.5.29
with the same version of LILO? (which version?)

Do you use the linear or lba32 options? The fix-table option?

What corruption do you see in the partition table?

Do you use LVM?

What happens under 2.5.30?

Andries
