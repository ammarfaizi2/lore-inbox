Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129518AbRBCEVx>; Fri, 2 Feb 2001 23:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129550AbRBCEVn>; Fri, 2 Feb 2001 23:21:43 -0500
Received: from snoopy.apana.org.au ([202.12.87.129]:40970 "HELO
	snoopy.apana.org.au") by vger.kernel.org with SMTP
	id <S129518AbRBCEVj>; Fri, 2 Feb 2001 23:21:39 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Fix for include/linux/fs.h in 2.4.0 kernels
In-Reply-To: <20010203004926.M160@pervalidus.dyndns.org>
	<12656.981169803@ocs3.ocs-net>
From: Brian May <bam@snoopy.apana.org.au>
X-Home-Page: http://snoopy.apana.org.au/~bam/
Date: 03 Feb 2001 15:21:31 +1100
In-Reply-To: kaos@ocs.com.au's message of "3 Feb 01 03:10:03 GMT"
Message-ID: <848znojt10.fsf@snoopy.apana.org.au>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Keith" == Keith Owens <kaos@ocs.com.au> writes:

    >> {PB} This was necessary for libc5, but is not correct when
    >> using glibc. Including the kernel header files directly in user
    >> programs usually does not work (see question 3.5). glibc
    >> provides its own <net/*> and <scsi/*> header files to replace
    >> them, and you may have to remove any symlink that you have in
    >> place before you install glibc. However, /usr/include/asm and
    >> /usr/include/linux should remain as they were.
    >> 
    >> Keith, are you saying that glibc is wrong?

    Keith> Not me, Linus says that glibc is wrong.

    Keith>   "I've asked glibc maintainers to stop the symlink
    Keith> insanity for the last few years now, but it doesn't seem to
    Keith> happen.

    Keith>   Basically, that symlink should not be a symlink.  It's a
    Keith> symlink for historical reasons, none of them very good any
    Keith> more (and haven't been for a long time), and it's a
    Keith> disaster unless you want to be a C library developer.
    Keith> Which not very many people want to be.

    Keith>   The fact is, that the header files should match the
    Keith> library you link against, not the kernel you run on."


I read Keith's response as: the symlink is wrong.
I read the glib FAQ as:     the symlink is wrong.
I read Linus' response as:  the symlink is wrong.

Who is contradicting who here?

(perhaps that last sentence in the glibc FAQ is confusing, however the
rest of it clearly says that glibc contains its own version of those
files, and a symlink should *not* be used. I think the part "[...] you
may have to remove any symlink [...]" is clear enough).
-- 
Brian May <bam@snoopy.apana.org.au>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
