Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946033AbWJZX4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946033AbWJZX4c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 19:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946029AbWJZX4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 19:56:31 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:24077 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1946033AbWJZX4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 19:56:30 -0400
Date: Fri, 27 Oct 2006 01:56:28 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: removing drivers and ISA support? [Was: Char: correct pci_get_device changes]
Message-ID: <20061026235628.GT27968@stusta.de>
References: <4540F79C.7070705@gmail.com> <20061026222525.GP27968@stusta.de> <9a8748490610261531s539b0861t621e95c785b53d7@mail.gmail.com> <45414641.6060709@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45414641.6060709@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2006 at 01:35:06AM +0159, Jiri Slaby wrote:
> Jesper Juhl wrote:
> > On 27/10/06, Adrian Bunk <bunk@stusta.de> wrote:
> >> On Thu, Oct 26, 2006 at 07:59:56PM +0200, Jiri Slaby wrote:
> >> >...
> >> > And what about (E)ISA support. When converting to pci probing,
> >> should be ISA bus
> >> > support preserved (how much is ISA used in present)? -- it makes
> >> code ugly and long.
> >>
> >> There seem to be still many running 486 machines - and only the last 486
> >> boards also had PCI slots.
> >>
> >> While deprecating OSS drivers, I got emails from people still using some
> >> of the ISA cards.
> 
> That might be a problem if the whole subsystem disappears, but if only ISA
> support from some driver is pruned away, they are still able to use the old
> driver by replacing the new one from some older kernel.
> Then, we'll get nicer drivers in return.

- this doesn't work for people using distribution kernels
- "by replacing the new one from some older kernel" doesn't sound
  reasonable - 3 or 4 point releases later it will have become pretty
  unlikely that the driver will still work unmodified
  (if you disagree, please name one ISA driver where the 2.6.15 version
   compiles without any modifications in 2.6.19-rc3)

> >> And there are even Pentium 4 boards with ISA slots available.
> >>
> > Not to mention many embedded boards - many pc104 boards use ISA, just
> > to mention one type.
> 
> I don't know if you understand me correctly (I might write it slightly unclear)
> and if I understand you correctly now. I didn't mean to wipe out the (E)ISA
> support from the kernel, I meant eliminating it from drivers which will be
> rewritten to pci probing.

Sure, but see my comment above.

> regards,

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

