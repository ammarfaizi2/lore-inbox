Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289088AbSAJAD0>; Wed, 9 Jan 2002 19:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289090AbSAJADR>; Wed, 9 Jan 2002 19:03:17 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:65182
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S289088AbSAJADB>; Wed, 9 Jan 2002 19:03:01 -0500
Date: Wed, 9 Jan 2002 17:02:16 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Torrey Hoffman <torrey.hoffman@myrio.com>
Cc: andersen@codepoet.org, Greg KH <greg@kroah.com>,
        linux-kernel@vger.kernel.org
Subject: Re: initramfs programs (was [RFC] klibc requirements)
Message-ID: <20020110000216.GS13931@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211CB23@mail0.myrio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211CB23@mail0.myrio.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2002 at 12:25:37PM -0800, Torrey Hoffman wrote:
 
> One of the neat things about moving a lot of this formerly in-kernel
> boot stuff to userspace is that it will be easier to do interesting
> customization of the boot process, without having to hack the kernel.

Right.  But in doing this we also don't want to bloat the very small
programs/functionality we currently hack directly in

> I'm sure that this will be used in lots of innovative ways that people
> haven't even thought of yet.  

Yes, but how many of these require a 'klibc' ?  One of the other tiny
libcs is probably a better bet for any sort of 'large' project.  IMHO,
the klibc stuff should be just big enough to support the 'normal' cases,
ie stuff we do now and related.

> So, I guess what I'd like to see with the initramfs build system is a 
> easy way to build little apps like sfdisk and mkreiserfs against the 
> libc it (normally) uses and add them to the ramdisk.

Well, occording to the spec file hpa posted, it's just a cpio(1)
archive, so anything is possible.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
