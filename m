Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293457AbSCXPiT>; Sun, 24 Mar 2002 10:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293461AbSCXPiJ>; Sun, 24 Mar 2002 10:38:09 -0500
Received: from d.su3.de ([62.153.150.130]:45908 "EHLO phobos.irda.amps.de")
	by vger.kernel.org with ESMTP id <S293457AbSCXPhu>;
	Sun, 24 Mar 2002 10:37:50 -0500
From: "Dr. Michael Rietz" <rietz@mail.amps.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15517.59845.731054.936129@phobos.irda.amps.de>
Date: Sun, 24 Mar 2002 15:59:17 +0100
To: hvr@hvrlab.org
Cc: linux-kernel@vger.kernel.org
Subject: Problems with cryptoapi and 2.4.17
In-Reply-To: <15491.52772.748962.975486@phobos.irda.amps.de>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: rietz@su3.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

I'm using the cryptoapi since more than a year (2.4.4)....  Now I tried to move
to newer kernel (2.4.17) and I'm not able to setup a loop device with
the new kernel..... 

I patched the 2.4.17 kernel with patch-int-2.4.17.0.gz,
                                 loop-jari-2.4.16.0.patch
 and everything compiled fine... 

I build the util-linux-2.11n with the new patches 
 and everything compiled fine....

then I loaded all modules cryptoapi,cipers, digest,
etc....  and tried:

# dd if=/dev/urandom of=file bs=1024k count=100
# losetup -e twofish /dev/loop0 file 
Available keysizes (bits): 128 192 256 
# Keysize: 256
# Password :
# Password :
The cipher does not exist, or a cipher module needs to be loaded into the kernel
ioctl: LOOP_SET_STATUS: Invalid argument

and thats it.... with every cipher.


Is there anybody out there who can help me ????
Any comment is welcome.

so long


-- 
Michael Rietz                                  e-mail: rietz@su3.de
                                                       MR1574-RIPE
