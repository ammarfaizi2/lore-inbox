Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274299AbRJEXCg>; Fri, 5 Oct 2001 19:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274337AbRJEXCQ>; Fri, 5 Oct 2001 19:02:16 -0400
Received: from www.transvirtual.com ([206.14.214.140]:32774 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S274299AbRJEXCK>; Fri, 5 Oct 2001 19:02:10 -0400
Date: Fri, 5 Oct 2001 16:02:08 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Etienne Lorrain <etienne_lorrain@yahoo.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New Input PS/2 driver
In-Reply-To: <20011006005006.A17152@suse.cz>
Message-ID: <Pine.LNX.4.10.10110051558000.31239-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Not implemented yet.
> 
> Quite the opposite: #undef was forgotten in the .h file after the .c
> file converted to a runtime option instead of a compiletime one. I
> removed it in the CVS now.

  Okay. Another thing is how to deal with IRQ's and the port regions. This
can vary from platform to platform. We could have this as a command line
option as well. In fact we might since it can be built as a module. Alot
of platforms added things to the command line inside the kernel code.
  Or we can do lots of #ifdef in i8042.h or using the asm/keyboard method
like now. Personally I don't like this method since even on mips the i8042
port range varies on different machines. So we still end up with a bunch
of messy #ifdef. 

