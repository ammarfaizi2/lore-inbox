Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130369AbRBCDK1>; Fri, 2 Feb 2001 22:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130577AbRBCDKS>; Fri, 2 Feb 2001 22:10:18 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:2055 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130369AbRBCDKK>;
	Fri, 2 Feb 2001 22:10:10 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Fr d ric L. W. Meunier" <0@pervalidus.net>
cc: Jocelyn Mayer <jocelyn.mayer@netgem.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fix for include/linux/fs.h in 2.4.0 kernels 
In-Reply-To: Your message of "Sat, 03 Feb 2001 00:49:26 -0200."
             <20010203004926.M160@pervalidus.dyndns.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 03 Feb 2001 14:10:03 +1100
Message-ID: <12656.981169803@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Feb 2001 00:49:26 -0200, 
Fr d ric L. W. Meunier <0@pervalidus.net> wrote:
>Keith Owens wrote:
>> Relying on /usr/include/{linux,asm} always pointing at the
>> current kernel source is broken as designed.
>
>From glibc 2.2.1 FAQ:
>
>2.17.   I have /usr/include/net and /usr/include/scsi as symlinks
>	into my Linux source tree.  Is that wrong?
>
>{PB} This was necessary for libc5, but is not correct when
>using glibc. Including the kernel header files directly in user
>programs usually does not work (see question 3.5). glibc
>provides its own <net/*> and <scsi/*> header files to replace
>them, and you may have to remove any symlink that you have in
>place before you install glibc. However, /usr/include/asm and
>/usr/include/linux should remain as they were.
>
>Keith, are you saying that glibc is wrong?

Not me, Linus says that glibc is wrong.

  "I've asked glibc maintainers to stop the symlink insanity for the
  last few years now, but it doesn't seem to happen.

  Basically, that symlink should not be a symlink.  It's a symlink for
  historical reasons, none of them very good any more (and haven't been
  for a long time), and it's a disaster unless you want to be a C
  library developer.  Which not very many people want to be.

  The fact is, that the header files should match the library you link
  against, not the kernel you run on."

http://www.mail-archive.com/linux-kernel@vger.rutgers.edu/2000-month-07/msg04096.html
for the rest of Linus's reasons.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
