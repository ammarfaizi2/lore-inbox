Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271643AbRH0DIH>; Sun, 26 Aug 2001 23:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271644AbRH0DH6>; Sun, 26 Aug 2001 23:07:58 -0400
Received: from zok.SGI.COM ([204.94.215.101]:54997 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S271643AbRH0DHr>;
	Sun, 26 Aug 2001 23:07:47 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Tom Rini <trini@kernel.crashing.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linuxppc-dev@lists.linuxppc.org,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.9-ac12 ppc ftr_fixup 
In-Reply-To: Your message of "Sun, 26 Aug 2001 19:54:58 MST."
             <20010826195458.D1481@cpe-24-221-152-185.az.sprintbbd.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 27 Aug 2001 13:07:50 +1000
Message-ID: <21144.998881670@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Aug 2001 19:54:58 -0700, 
Tom Rini <trini@kernel.crashing.org> wrote:
>> >On Mon, Aug 27, 2001 at 10:27:22AM +1000, Keith Owens wrote:
>> >
>> >> 2.4.9-ac12 has new ppc code for CPU feature fixups.  The ftr_fixup code
>> >> only handles entries that are built into the kernel.  timex.h defines
>> >> get_cycles() using ftr_fixup and get_cycles() is used all over the
>> >> place, including in modules.  AFAICT we need to add modutils support
>> >> for ftr_fixup.
>Hmm..  I'm guessing no one's tried get_cycles from a module on a 601 in
>ages...

OK, so insmod needs to pass the ftr_fixup data for modules into the
kernel, I will add the ftp_fixup section as archdata in insmod.  Do not
code any kernel change to use ftr_fixup in modules until Maciej W.
Rozycki's patch for module archdata handling is in.

