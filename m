Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312426AbSDEJvH>; Fri, 5 Apr 2002 04:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312431AbSDEJu5>; Fri, 5 Apr 2002 04:50:57 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:20535 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S312426AbSDEJum>; Fri, 5 Apr 2002 04:50:42 -0500
To: Martin Mares <mj@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 Boot enhancements, pic 16 4/9
In-Reply-To: <m11ydwu5at.fsf@frodo.biederman.org> <20020405080115.GA409@ucw.cz>
	<m1k7rmpmyq.fsf@frodo.biederman.org> <20020405084733.GG609@ucw.cz>
	<m1g02aplmm.fsf@frodo.biederman.org> <20020405090846.GL609@ucw.cz>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 05 Apr 2002 02:44:09 -0700
Message-ID: <m1bscypjiu.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Mares <mj@ucw.cz> writes:

> Hello!
> 
> > Show me a linker script that can link together bootsect.o and bsetup.o.
> 
> I don't have enough time to experiment with it at this very moment
> and I admit that the linker bugs you've mentioned make it impossible,
> but the objdump solution I mentioned (and tried a couple of minutes ago)
> works and although it isn't perfect, it's lovely compared to the
> "-start" hack.

Given that I want a relative offset, and I have explicitly coded a
relative offset, I don't see how that is a hack.  I see assembly
for is telling the machine explicitly what to do and that does.

The fact the correct way to code the instruction looks ugly is a gas
bug/deficiency.  Perhaps a gas developer will look at how ugly that
code is and improve gas.

One of the other reasons I want to do it this way is in case is to
make copying code easier.  If you use idioms that work equally well
everywhere and for every case it is easier to switch between projects
using the same tool.  And the assume 0 hack isn't useful when
switching from real to protected mode while using the code segment
you got from the reset vector.  Although it is kind of fun running
real mode code with a code segment base of 0xffff0000.

Eric
