Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263527AbREYEe0>; Fri, 25 May 2001 00:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263524AbREYEeQ>; Fri, 25 May 2001 00:34:16 -0400
Received: from vitelus.com ([64.81.36.147]:24074 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S263527AbREYEeF> convert rfc822-to-8bit;
	Fri, 25 May 2001 00:34:05 -0400
Date: Thu, 24 May 2001 21:34:04 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: linux-kernel@vger.kernel.org
Subject: Fwd: Copyright infringement in linux/drivers/usb/serial/keyspan*fw.h
Message-ID: <20010524213404.A22585@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message sparked a long thread on the debian-legal mailing list,
which is long since dead. I am personally very curious about whether
this has been resolved upstream. I consider it a very important issue,
which is why I asked for RMS' opinion. He said that what is being done
is clearly not "mere aggregation", and that such firmware should be
moved out of the kernel (and even the tarball) to stop violating the
GPL and make Linux be free software.

As a user of hardware which requires firmware like this, I have mixed
feelings, but feel strongly that requirements of the GPL clearly
override any measure of convenience. Are there any plans to remove the
binary-only firmware from the kernel, and/or eventually from the Linux
source distribution? I am not refering to this USB driver
specifically, but rather the general occurance of firmware embedded in
Linux device trivers.

----- Forwarded message from "Adam J. Richter" <adam@yggdrasil.com> -----

From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 22 Apr 2001 12:53:48 -0700
To: debian-legal@lists.debian.org
Subject: Copyright infringement in linux/drivers/usb/serial/keyspan*fw.h


	Linus's Linux kernel releases from 2.3.50 through the latest
test release (2.4.4-pre6) contain GPL-incompatible "firmware" images
for "EZUSB" devices in linux/drivers/usb/serial/keyspan*fw.h, which
are #included into drivers which contain GPL'ed code, even when compiled
as modules.

	I believe this infringinges the copyrights of the authors
of the code used in these drivers who released their code under GPL.
Alan Cox, has gone on a campaign claiming that this is "mere aggregation"
and insists that I bring in the lawyers to prove him otherwise.  I
really do not want to take this step, but he is forcing my hand.  Note
that Yggdrasil is a copyright owner in this case.

	To simplify removal of the offending code, I have provided
a separate user level facility that can use the USB "hot plugging"
system to automatically load that "firmware" or any other.  The USB serial
maintainer already plans to switch to it in 2.5, and has tested it and
verified that it works.  The software and a kernel patch to remove
the offending code is FTPable from
ftp://ftp.yggdrasil.com/pub/dist/device_control/ezusb/.  The kernel patch
also moves the "whiteheat" code loading into the same user space utility,
just for technical reasons, even though that code can apparently be legally
included in the kernel.  Note that even without this software, the EZUSB
firmware can apparently be loaded by other facilities or from other
operating systems.

	Here is what people involved in Debian should do:

		1. Make sure that no Debian release or snapshot that
		   includes a kernel from 2.3.50 through the current
		   one (don't know if there are any yet) includes
		   linux/drivers/usb/serial/keyspan*fw.h.  By the way,
		   even if there were no legal liability, these files
		   could not be in the "free" part of Debian, if I
		   read the Debian Free Software "Guidelines" correctly.

		2. Possibly include the user level software FTPable from
		   Yggdrasil, although be warned that that code will probably
		   be replaced in the near future to use an input file
		   format more compatible with other development tools used
		   for EZUSB 8051 microcontroller software development.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."


-- 
To UNSUBSCRIBE, email to debian-legal-request@lists.debian.org
with a subject of "unsubscribe". Trouble? Contact listmaster@lists.debian.org



----- End forwarded message -----

-- 
#define m(i)(x[i]^s[i+84])<< /* I do not condone improper use of this code */
unsigned char x[5],y,s[2048];main(n){for(read(0,x,5);read(0,s,n=2048);write(1,s
,n))if(s[y=s[13]%8+20]/16%4==1){int i=m(1)17^256+m(0)8,k=m(2)0,j=m(4)17^m(3)9^k
*2-k%8^8,a=0,c=26;for(s[y]-=16;--c;j*=2)a=a*2^i&1,i=i/2^j&1<<24;for(j=127;++j<n
;c=c>y)c+=y=i^i/8^i>>4^i>>12,i=i>>8^y<<17,a^=a>>14,y=a^a*8^a<<6,a=a>>8^y<<9,k=s
[j],k="7Wo~'G_\216"[k&7]+2^"cr3sfw6v;*k+>/n."[k>>4]*2^k*257/8,s[j]=k^(k&k*2&34)
*6^c+~y;}}//Please join us in civil disobedience and distribute DeCSS(or efdtt!)
