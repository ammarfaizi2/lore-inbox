Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288722AbSADSrQ>; Fri, 4 Jan 2002 13:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288719AbSADSrI>; Fri, 4 Jan 2002 13:47:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20996 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S288675AbSADSq6>;
	Fri, 4 Jan 2002 13:46:58 -0500
Message-ID: <3C35F89E.2EA5E811@mandrakesoft.com>
Date: Fri, 04 Jan 2002 13:46:54 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: David Woodhouse <dwmw2@infradead.org>, Dave Jones <davej@suse.de>,
        Linus Torvalds <torvalds@transmeta.com>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: including kernel headers (was Re: PATCH 2.5.2.7: io.h cleanup and 
 userspace nudge)
In-Reply-To: <E16MZFt-000548-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Just putting it asm-*/types.h should just about be enough.
> 
> That is one of the headers glibc wants to import however. It wants to be
> hard for applications to do something stupid  but easy for glibc to extract
> the relevant data that it actually needs (because glibc needs the kernel to
> user information to make syscalls even if it doesnt expose them to apps)

Thinking -long term- here, I wonder what a good solution for glibc would
be?  Userspace including glibc should never include kernel headers but I
100% agree we should make it as easy as possible for glibc (and other
libc's) to stay in sync with the kernel<->userspace API.

I am betting glibc does not require as much work to become independent
of kernel headers... it is more work to get all the userspace apps that
reference ioctl structures and constants not using kernel headers.

	Jeff



-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
