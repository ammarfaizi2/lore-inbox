Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129939AbRA0GxQ>; Sat, 27 Jan 2001 01:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130766AbRA0GxG>; Sat, 27 Jan 2001 01:53:06 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:29192 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129939AbRA0Gw6>;
	Sat, 27 Jan 2001 01:52:58 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Sergey Kubushin" <ksi@cyberbills.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0ac12 
In-Reply-To: Your message of "Fri, 26 Jan 2001 17:46:12 -0800."
             <Pine.LNX.4.31ksi3.0101261742080.598-100000@nomad.cyberbills.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 27 Jan 2001 17:52:51 +1100
Message-ID: <29609.980578371@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jan 2001 17:46:12 -0800 (PST), 
"Sergey Kubushin" <ksi@cyberbills.com> wrote:
>Modules still don't load:
>
>=== Cut ===
>ide-mod.o: Can't handle sections of type 32131
>ide-probe-mod.o: Can't handle sections of type 256950710
>ide-disk.o: Can't handle sections of type 688840897
>ext2.o: Can't handle sections of type 69429248
>=== Cut ===

Works for me.

# uname -a
Linux ocs4 2.4.0-ac12 #1 SMP Sat Jan 27 17:37:12 EST 2001 i686 unknown
# lsmod
Module                  Size  Used by
binfmt_misc             3696   0 
nfsd                   71632   0  (autoclean)
vfat                   11504   1 
fat                    32448   0  [vfat]
af_packet               8720   0  (unused)
isofs                  19216   0  (unused)
sg                     26752   0  (unused)
loop                    7680   0  (unused)
nfs                    82720   0  (unused)
lockd                  50416   0  [nfsd nfs]
sunrpc                 62464   0  [nfsd nfs lockd]
tulip                  37232   1 
# insmod -V 2>&1 | head -1
insmod version 2.4.2
# gcc -v
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/specs
gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)
# ld -v
GNU ld version 2.9.5 (with BFD 2.9.5.0.22)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
