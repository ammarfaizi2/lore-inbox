Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266660AbRGEIf2>; Thu, 5 Jul 2001 04:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264865AbRGEIfJ>; Thu, 5 Jul 2001 04:35:09 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:50356 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S266660AbRGEIe7>;
	Thu, 5 Jul 2001 04:34:59 -0400
Message-ID: <3B4426AC.465712DE@mandrakesoft.com>
Date: Thu, 05 Jul 2001 04:34:52 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@idb.hist.no>,
        Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Acpi] Re: ACPI fundamental locking problems
In-Reply-To: <Pine.LNX.4.33.0107040956310.1668-100000@penguin.transmeta.com> <3B442354.BCA61010@idb.hist.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> I am fine with "You have to use initrd (or similiar) _if_ you want this
> feature."
> But please don't make initrd mandatory for those of us who don't
> need ACPI, don't need dhcp before mounting disks and so on.

I've always thought it would be neat to do:

	cat bzImage initrd.tar.gz > vmlinuz
	rdev --i-have-a-tarball-piggyback vmlinuz

Linking into the image is easy for hackers, but why not make it
scriptable and super-easy for end users?  x86 already has the rdev
utility to mark a kernel image as having certain flags.  It could even
be a command line option, "inittgz" or somesuch, telling us that a
gzip-format tarball immediately follows the end of our ELF image.

I wonder if any bootloader mods would be needed at all to do this... 
AFAICS you just need to make sure the kernel doesn't trample the
piggyback'd data.

-- 
Jeff Garzik      | Thalidomide, eh? 
Building 1024    | So you're saying the eggplant has an accomplice?
MandrakeSoft     |
