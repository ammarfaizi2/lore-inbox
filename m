Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129825AbQJ2WFT>; Sun, 29 Oct 2000 17:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129787AbQJ2WFI>; Sun, 29 Oct 2000 17:05:08 -0500
Received: from mnh-1-06.mv.com ([207.22.10.38]:64004 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S129825AbQJ2WEy>;
	Sun, 29 Oct 2000 17:04:54 -0500
Message-Id: <200010292312.SAA02001@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: viro@math.psu.edu, torvalds@transmeta.com (Linus Torvalds),
        paulus@linuxcare.com.au (Paul Mackerras), linux-kernel@vger.kernel.org
Subject: Re: page->mapping == 0 
In-Reply-To: Your message of "Sun, 29 Oct 2000 20:32:00 GMT."
             <E13pz7a-0006JY-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 29 Oct 2000 18:12:00 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alan@lxorguk.ukuu.org.uk said:
> Well the ptrace one still has mysteriously breaks usermode linux
> against it on my list here. Was that ever explained. It looked like
> the stack got corrupted which is weird.

If this is the test8 "turn off ORIG_EAX if EIP is changed" fix, it apparently 
also broke a couple of other ptrace-intensive things which aren't coming to 
mind (Andi Kleen noticed them).

AFAIK, it was never explained.  Something would change its victim's EIP and 
the victim would segfault as soon as it was continued.

				Jeff


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
