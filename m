Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293207AbSBWVKs>; Sat, 23 Feb 2002 16:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293210AbSBWVKg>; Sat, 23 Feb 2002 16:10:36 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:4112 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293207AbSBWVKY>; Sat, 23 Feb 2002 16:10:24 -0500
Subject: Re: [PATCH] Lightweight userspace semaphores...
To: lm@bitmover.com (Larry McVoy)
Date: Sat, 23 Feb 2002 21:22:59 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds), mingo@elte.hu (Ingo Molnar),
        rusty@rustcorp.com.au (Rusty Russell),
        matthew@hairy.beasts.org (Matthew Kirkwood),
        bcrl@redhat.com (Benjamin LaHaise), david@mysql.com (David Axmark),
        wli@holomorphy.com (William Lee Irwin III),
        linux-kernel@vger.kernel.org
In-Reply-To: <20020223102805.F11156@work.bitmover.com> from "Larry McVoy" at Feb 23, 2002 10:28:05 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ejdD-000690-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Exactly.  SMP gives you coherent memory and test-and-set or some other
> atomic operation.  Why not use it?

Coherent memory on some platforms, locks on some platforms. Fortunately both
on several important architectures. It needs a much cleaner API but in
user space to wrap the user mode/kernel mode mixed locks. You need the
kernel side for sleeping cases
