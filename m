Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268490AbTANBrR>; Mon, 13 Jan 2003 20:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268487AbTANBrR>; Mon, 13 Jan 2003 20:47:17 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:23090 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S268490AbTANBrQ>; Mon, 13 Jan 2003 20:47:16 -0500
To: davidm@hpl.hp.com
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Sam Ravnborg <sam@ravnborg.org>,
       Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Consolidate vmlinux.lds.S files
References: <20030113180450.GA1870@mars.ravnborg.org>
	<Pine.LNX.4.44.0301131309240.24477-100000@chaos.physics.uiowa.edu>
	<15907.5503.334066.50256@napali.hpl.hp.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 Jan 2003 18:54:20 -0700
In-Reply-To: <15907.5503.334066.50256@napali.hpl.hp.com>
Message-ID: <m1r8bgfqcz.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger <davidm@napali.hpl.hp.com> writes:

>   Kai> I would suggest an approach like the following, of course
>   Kai> showing only a first simple step. A series of steps like this
>   Kai> should allow for a serious reduction in size of
>   Kai> arch/*/vmlinux.lds.S already, while being obviously correct and
>   Kai> allowing archs to do their own special thing if necessary (in
>   Kai> particular, IA64 seems to differ from all the other archs).
> 
> The only real difference for the ia64 vmlinux.lds.S is that it
> generates correct physical addressess, so that the boot loader doesn't
> have to know anything about the virtual layout of the kernel.
> Something that might be useful for other arches as well...

Thank you.  I appreciate it.

Having the physical addresses there makes writing a sane bootloader
simpler. 

Alpha practically does this except there is a fixed virtual offset added to
everything.

In general anything that gives us correct physical addresses makes
like much simpler on the bootloader..


Eric
