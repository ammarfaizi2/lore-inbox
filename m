Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261310AbSJCPqB>; Thu, 3 Oct 2002 11:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261325AbSJCPqA>; Thu, 3 Oct 2002 11:46:00 -0400
Received: from pool-151-204-76-45.delv.east.verizon.net ([151.204.76.45]:8975
	"HELO trianna.2y.net") by vger.kernel.org with SMTP
	id <S261310AbSJCPp7>; Thu, 3 Oct 2002 11:45:59 -0400
Date: Thu, 3 Oct 2002 11:52:03 -0400
From: Malcolm Mallardi <magamo@ranka.2y.net>
To: linux-kernel@vger.kernel.org
Subject: [2.4.19] EFS CDROM IDE-SCSI bug
Message-ID: <20021003155203.GA17245@trianna.upcommand.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I am attempting to mount an EFS filesystem on a CD-ROM in
/dev/cdrom, aka /dev/scd0 (when under IDE-SCSI emulation) aka /dev/hdc
when just under the normal IDE-CD driver.  When I mount the CD under
normal IDE circumstances, it works just fine.  When I try it when the
CD is SCSI emulated, mount segfaults, and a kernel BUG gets spit into
my kernel logs:

EFS: 1.0a - http://aeschi.ch.eu.org/efs/
kernel BUG at buffer.c:2497!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0135e12>]    Not tainted
EFLAGS: 00010206
eax: 000007ff   ebx: 0000000b   ecx: 00000800   edx: c7c814a0
esi: 00000000   edi: 00000b00   ebp: 00000000   esp: c39b9e44
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 17570, stackpage=c39b9000)
Stack: 00000b00 00000200 00000000 00000000 00001000 c01340a7 00000b00 00000000 
       00000200 c0222614 c4763a00 c4763acc c0134294 00000b00 00000000 00000200 
       00000000 c8a35219 00000b00 00000000 00000200 c0222614 c4763a00 c405c220 
Call Trace:    [<c01340a7>] [<c0134294>] [<c8a35219>] [<c0136fe0>] [<c8a36900>]
  [<c8a36900>] [<c01457b6>] [<c013719b>] [<c8a36900>] [<c0146699>] [<c0146962>]
  [<c01467b4>] [<c0146ce4>] [<c010856f>]

Code: 0f 0b c1 09 00 c6 1f c0 8b 44 24 20 05 00 fe ff ff 3d 00 0e 

I would wash that through ksymoops, but I can't get it to compile due
to a linking error.  Right now, I don't know if this is an issue with
the EFS filesystem driver, or with IDE-SCSI, but either/or. :)
--
Malcolm D. Mallardi - Dark Freak At Large
"Captain, we are receiving two-hundred eighty-five THOUSAND hails."
AOL: Nuark  UIN: 11084092 Y!: Magamo Jabber: Nuark@jabber.com
http://ranka.2y.net:8008/~magamo/index.htm
