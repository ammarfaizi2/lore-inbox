Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268949AbRHLET5>; Sun, 12 Aug 2001 00:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268957AbRHLETr>; Sun, 12 Aug 2001 00:19:47 -0400
Received: from smtp6.mindspring.com ([207.69.200.110]:42554 "EHLO
	smtp6.mindspring.com") by vger.kernel.org with ESMTP
	id <S268949AbRHLETd>; Sun, 12 Aug 2001 00:19:33 -0400
Message-ID: <3B760463.4A4E0CC9@mindspring.com>
Date: Sat, 11 Aug 2001 21:21:55 -0700
From: Joe <joeja@mindspring.com>
Reply-To: joeja@mindspring.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: emu10k1.o  and 2.4.8 don't compile
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a SB LIve sound card and now I cannot compile the emu10k soudn
driver to run it in 2.2.8.

Apparantly someone defined MODULE_AUTHOR, MODULE_DESCRIPTION,
init_module and cleanup_module in both the main.c and joystick.c files
not sure what else is defined twice either.

I think I can just comment out one definition / function but not sure
which one.  Does anyone know or has anyone seen this yet?

I patch a 2.4.7 kernel with the patch from ftp.kernel.org.

Joe (cc me I am not on the list)


The following is the compiler message:

main.o(.modinfo+0x20): multiple definition of `__module_author'
joystick.o(.modinfo+0x80): first defined here
ld: Warning: size of symbol `__module_author' changed from 67 to 81 in
main.o
main.o(.modinfo+0x80): multiple definition of `__module_description'
joystick.o(.modinfo+0xe0): first defined here
ld: Warning: size of symbol `__module_description' changed from 83 to 96
in main.o
main.o: In function `init_module':
main.o(.text+0x1a70): multiple definition of `init_module'
joystick.o(.text+0x2d0): first defined here
main.o: In function `cleanup_module':
main.o(.text+0x1ab0): multiple definition of `cleanup_module'
joystick.o(.text+0x310): first defined here
make[3]: *** [emu10k1.o] Error 1
make[2]: *** [_modsubdir_emu10k1] Error 2
make[1]: *** [_modsubdir_sound] Error 2
make: *** [_mod_drivers] Error 2
cp: cannot stat `emu10k1.o': No such file or directory
make[3]: *** [_modinst__] Error 1
make[2]: *** [_modinst_emu10k1] Error 2
make[1]: *** [_modinst_sound] Error 2
make: *** [_modinst_drivers] Error 2

