Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbUCPW0h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 17:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbUCPW0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 17:26:37 -0500
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:2176 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261757AbUCPW0c (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 17:26:32 -0500
Message-Id: <200403162226.i2GMQTGp003101@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Nick Orlov <bugfixer@list.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-mm1 hangs after Uncompressing kernel... 
In-Reply-To: Your message of "Tue, 16 Mar 2004 12:51:56 EST."
             <20040316175156.GA11785@nikolas.hn.org> 
From: Valdis.Kletnieks@vt.edu
References: <20040316175156.GA11785@nikolas.hn.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_20999636P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 16 Mar 2004 17:26:29 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_20999636P
Content-Type: text/plain; charset=us-ascii

On Tue, 16 Mar 2004 12:51:56 EST, Nick Orlov <bugfixer@list.ru>  said:
> 2.6.5-rc1-mm1 with 4k-stacks-always-on reverted hangs after
> "Uncompressing kernel ..."
> 
> reverting early-x86-cpu-detection-fix solved the problem for me.

I had issues with that patch as well, except that rather than a hang, I'd
get 'Uncompressing kernel...' and then the screen would clear and instead
of a penguin logo and boot messages, there'd be a second or so of silence
and then the dread 'ka-chunk' of the machine resetting for a reboot,
and then I'd be looking at the BIOS screen again.

Reverting that patch fixed it for me as well.

I'm running on a Dell Latitude C840, /proc/cpuinfo says:

% cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 Mobile CPU 1.60GHz
stepping        : 4
cpu MHz         : 1595.574
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 3153.92

As usual, I'm willing to test additional/revised patches if needed...

--==_Exmh_20999636P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAV38UcC3lWbTT17ARAjfZAJ0RfcreElDmV3R/vHQlvYk31fGk4gCg85P2
lq+XfWflcU8uBfcLwBevOYo=
=TM7l
-----END PGP SIGNATURE-----

--==_Exmh_20999636P--
