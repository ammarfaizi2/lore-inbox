Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129463AbQJ0Xso>; Fri, 27 Oct 2000 19:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129495AbQJ0Xse>; Fri, 27 Oct 2000 19:48:34 -0400
Received: from correo02.adinet.com.uy ([206.99.44.215]:50894 "EHLO
	correo02.adinet.com.uy") by vger.kernel.org with ESMTP
	id <S129463AbQJ0XsZ>; Fri, 27 Oct 2000 19:48:25 -0400
Message-ID: <39FA1332.ED6EF857@adinet.com.uy>
Date: Fri, 27 Oct 2000 20:43:46 -0300
From: Ivan Baldo <lubaldo@adinet.com.uy>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test9 i586)
X-Accept-Language: es, en, it
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Linux Uruguay <linux-uy@linux.org.uy>, SET <salvador@inti.gov.ar>
Subject: [Fwd: Bug in Linux VFAT filesystem: truncating file to greather size!]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello.
	I have sent this to the maintainer of the VFAT code some time ago and
it told me it doesn't have time.
	It seems there is a bug and this bug still persists in 2.2.17 and
2.4.0-test9 (test9 says there is a bug on file.c line 69 and sometimes
on line 79 I think, I think this is the file.c of VFAT which has code
for reporting that bug on those lines).
	Also note that there is a bug in kernel 2.4.0-test9 regarding to long
filenames on VFAT32 filesystems (it doesn't create them ok, test with
Scandisk or Norton Disk Doctor), you can easily check that.
	Sorry this is somewhat vague, but I don't have much free time right
now, yet I will try to answer your questions or try to help you as much
as I can, so don't doubt to email me (I am not on the mailing list!).
	I hope you can reproduce both of this bugs and fix them.
	Thank you very much guys!

	Here is the email I sent to the maintainer:

-------- Original Message --------
From: Ivan Baldo <lubaldo@adinet.com.uy>
Subject: Bug in Linux VFAT filesystem: truncating file to greather size!
To: chaffee@bmrc.cs.berkeley.edu
CC: SET <salvador@inti.gov.ar>, Gonzalo Piano <mpsggpep@adinet.com.uy>

	Hello.
	Please, if it is not you the correct person to email the bug, then
point me in the right direction and excuse me.
	Do this:
		- create a small C program that calls the "truncate()" function to
increase the size of an already existing file. Note that I am saying
*increase the size*, wich it is different from *truncating the file*.
Make sure the file is in a mounted VFAT filesystem and that both the
file and the increase in size are big (use 1mb for created file and
increase it to 2mb for example, or use greater  random values).
		- unmount filesystem and check with your favourite program (I have
used Microsoft Scandisk and Norton Disk Doctor, I have not tryed
dosfsck...). Your checking program will say that the file has some sort
of bad allocation issues, etc. Don't worry, it does not seem to kill the
filesystem, only the file you created and tested.

	Tested with home-compiled 2.2.15 Kernel, I have used GCC 2.95.2 and
binutils 2.9.5.0.22, most of the things are compiled statically (not as
modules), the filesystem things are all compiled statically. Another
friend tested with its 2.2.15 kernel, *and* another friend tested with
its 2.0.38 kernel!!! In all cases we have managed to reproduce the
problem! I have a little C program for doing this... it is in spanish
language but I think you will not need it... anyway, if you want this
program I can translate a bit of it (the code...) and send it to you.

	I haven't researched which kernel doesn't has the bug, because I don't
have older kernels (disk space and cleaning issues and my internet
connection isn't very cheap) and because I have a big lack of free time.

	I hope you can reproduce the problem and fix it easily.
	If you want more information and maybe some more help (take in account
that I am not a very knowledgeable person... so I can do only easy
things...), then just email me! Maybe you want me to test a patch or
something...

	Ok, thanks you so much! Bye.

P.s.: Netscape Messenger seems to rely on the ability to truncate a file
to a bigger size, but it uses it only for non important files (the
message files doesn't seem to have this problem, but the .summary files
do).
-- 
Ivan Baldo:
lubaldo@adinet.com.uy - http://members.xoom.com/baldo - ICQ 10215364
Phone: (598) (2) 613 3223.
Caldas 1781, Malvin, Montevideo, Uruguay, South America.

(If you have problems with the previous addresses, try this ones:
ibaldo@usa.net, http://baldo.home.ml.org).

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
