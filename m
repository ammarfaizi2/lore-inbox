Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285692AbSBYRSr>; Mon, 25 Feb 2002 12:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292387AbSBYRSh>; Mon, 25 Feb 2002 12:18:37 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38416 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285692AbSBYRSb>; Mon, 25 Feb 2002 12:18:31 -0500
Subject: Re: [PATCH] Lightweight userspace semaphores...
To: torvalds@transmeta.com (Linus Torvalds)
Date: Mon, 25 Feb 2002 17:31:26 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), rusty@rustcorp.com.au (Rusty Russell),
        mingo@elte.hu, matthew@hairy.beasts.org (Matthew Kirkwood),
        bcrl@redhat.com (Benjamin LaHaise), david@mysql.com (David Axmark),
        wli@holomorphy.com (William Lee Irwin III),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0202250905090.3392-100000@home.transmeta.com> from "Linus Torvalds" at Feb 25, 2002 09:06:15 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16fOyE-0005Xl-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > unlink()
> 
> Sure, but that, together with making up a unique temporary name etc just
> adds extra overhead for no actual gain.

As opposed to adding special cases to the kernel which are unswappable and
stand to tangle up bits of the generic vfs - eg we would have a vma with
a vm_file but that file would not be in the dcache ?

Is it really worth it. For temporary files unix has never adopted a tmpfile()
syscall because nobody has ever found mkstemp() a paticularly critical path
that justified it
