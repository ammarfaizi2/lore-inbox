Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132521AbQLJAse>; Sat, 9 Dec 2000 19:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132548AbQLJAsY>; Sat, 9 Dec 2000 19:48:24 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:57104 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S132521AbQLJAsR>;
	Sat, 9 Dec 2000 19:48:17 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        Eyal Lebedinsky <eyal@eyal.emu.id.au>
Subject: Re: Linux 2.2.18 almost... 
In-Reply-To: Your message of "Sat, 09 Dec 2000 18:32:56 CDT."
             <3A32C128.1ED29FA2@holly-springs.nc.us> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 10 Dec 2000 11:17:43 +1100
Message-ID: <15713.976407463@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 09 Dec 2000 18:32:56 -0500, 
Michael Rothwell <rothwell@holly-springs.nc.us> wrote:
>Alan Cox wrote:
>> The patch I intend to be 2.2.18 is out as 2.2.18pre26 in the usual place.
>> I'll move it over tomorrow if nobody reports any horrors, missing files etc
>
>Fresh 2.2.17, "patch -p1 < /pre-patch-2.2.18-26"
>
>can't find file to patch at input line 38909
>Perhaps you used the wrong -p or --strip option?
>The text leading up to this was:
>--------------------------
>|diff -u --new-file --recursive --exclude-from /usr/src/exclude
>v2.2.17/arch/i386/vmlinux.lds linux/arch/i386/vmlinux.lds
>|--- v2.2.17/arch/i386/vmlinux.lds	Wed May  3 21:22:13 2000
>|+++ linux/arch/i386/vmlinux.lds	Sat Dec  9 21:23:21 2000

Ignore that bit of the patch.  arch/i386/vmlinux.lds is generated from
arch/i386/vmlinux.lds.S and the latter is correctly patched.  The patch
for arch/i386/vmlinux.lds should not have been generated.

<rant size="small">
There are a lot of unnecessary inconsistencies between architectures.
Some archs generate vmlinux.lds from vmlinux.lds.S, some from
vmlinux.lds.in, some do not generate vmlinux.lds, it is shipped in the
tarball.  The inconsistencies make it difficult to distinguish between
files that are generated (not shipped, ignore for patching) and master
files (shipped in tar ball, check for patches).

There is a similar problem with oops text.  Each architecture needs an
oops report but each one prints it differently.

I implore architecture maintainers to adopt a common approach to
generated files, oops reports etc.  Remember that each arch needs to be
part of the common tar ball and has to operate with a single set of
make and other user space tools.
</rant>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
