Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264625AbRFPR4e>; Sat, 16 Jun 2001 13:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264634AbRFPR4W>; Sat, 16 Jun 2001 13:56:22 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:728 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S264625AbRFPR4S>;
	Sat, 16 Jun 2001 13:56:18 -0400
Message-ID: <3B2B9DA3.3E310BF7@mandrakesoft.com>
Date: Sat, 16 Jun 2001 13:55:47 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Eric Smith <eric@brouhaha.com>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>, arjanv@redhat.com, mj@ucw.cz
Subject: Re: 2.4.2 yenta_socket problems on ThinkPad 240
In-Reply-To: <E15BG4h-000842-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > I would love to just define it unconditionally for x86, but I believe
> > Martin said that causes problems with some hardware, and the way the
> > BIOS has set up that hardware.  (details anyone?)
> 
> Im not sure unconditionally is wise. However turning it into a routine that
> walks the PCI bus tree and returns 1 if  a duplicate is found seems to be
> a little bit less likely to cause suprises

That would work, but is really a bandaid because we don't know what the
real problem is...  this still smells vaguely like yenta and pci bus
core should be more than just the kissing cousins they are now.  OTOH I
still don't like how much we trust firmware PCI bus setup on x86..

I am pretty lucky on Alpha, we already trust the kernel PCI code
implicitly by unconditionally defining pcibios_assign_all_busses to one.
:)

	Jeff


-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
