Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275654AbRIZWJu>; Wed, 26 Sep 2001 18:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275653AbRIZWJk>; Wed, 26 Sep 2001 18:09:40 -0400
Received: from [209.202.108.240] ([209.202.108.240]:34823 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S275654AbRIZWJa>; Wed, 26 Sep 2001 18:09:30 -0400
Date: Wed, 26 Sep 2001 18:09:41 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Binary only module overview
In-Reply-To: <E15mMhP-00021p-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0109261759350.27586-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2001, Alan Cox wrote:

> > What about programs that include header files from /usr/include/linux,
> > /usr/include/asm, and/or /usr/include/scsi?
>
> I believe you cannot copyright an interface just an implementation of it.
> I suspect someone more familiar in law can give the required precise info
> on that boundary
>
> That is the security layer issue is one of "does it depend on the linux
> kernel to work, is it deriving from the kernel and the GPL'd module for
> security plugins" not about the precise structs and #defines.

There are two things that work together cause problems, however:

1) The kernel header files are part of the Linux package, therefore unless a
specific license is applied to these files, they are covered by the license
applied to the entire package, i.e., GPL.

2) I agree that the structs and #define values contained within the header
files are not a problem; there is no transfer of code, only the information
about data formats and contents. OTOH, the #define macros, e.g., the ioctl()
stuff, may cause a problem due to the fact that cpp does in fact take the code
contained in these macros and inserts it into the program.

Therefore, it can be said that anything that uses the header macros must also
be under the GPL. Certainly this is a ridiculous idea, but it is one that
requires additional clarification.

The best solution is probably to make all header files in <linux-src>/include
LGPLed, and make the additional requirement in the Linux license that anything
in <linux-src>/include must also be LGPLed.

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>



