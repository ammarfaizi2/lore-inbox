Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422642AbWJXVpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422642AbWJXVpM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 17:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161253AbWJXVpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 17:45:12 -0400
Received: from webserve.ca ([69.90.47.180]:15061 "EHLO computersmith.org")
	by vger.kernel.org with ESMTP id S1161252AbWJXVpL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 17:45:11 -0400
Message-ID: <453E8921.2090406@wintersgift.com>
Date: Tue, 24 Oct 2006 14:44:01 -0700
From: teunis <teunis@wintersgift.com>
User-Agent: Icedove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc3: known unfixed regressions: confirmations
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org> <20061024202104.GF27968@stusta.de>
In-Reply-To: <20061024202104.GF27968@stusta.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Adrian Bunk wrote:
> This email lists some known unfixed regressions in 2.6.19-rc3 compared 
> to 2.6.18.
...

I'm not directly testing -rc3 as yet...  rc2-mm2 + a few modifications
works on the equipment I'm testing and as I can't afford more lost time
due to faults - I'm keeping to that build for the short term.

> Subject    : shutdown problem
> References : http://lkml.org/lkml/2006/10/22/140
> Submitter  : art@usfltd.com
>              teunis@wintersgift.com
>              Jiri Slaby <jirislaby@gmail.com>
> Status     : unknown

repaired by Jeff Dike's patch to fs/proc/array.c


VFAT failure: inode.c patch worked.   Has this been fixed in -rc3?
(email I've reviewed implies no)

HP nx6110 and nx6310 (i945G chipsets) - ACPI S3 and S4 (is that right?)
now fully operational.  speedstep not yet operational on nx6310 (Yonah).

synaptic driver: does not recover in S3 mode on nx7400 () or Acer
TravelMate 8000 (Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
USB UHCI)
Suspect USB host problem as synaptic driver DOES recover on nx6130.
This IS a regression as these worked fine in kernels where S3 formerly
worked.    Video does not yet fully recover on nx7400 - but it never has
so that's not a regression  (backlight fails to recover).

Any idea when Yonah (family 6/model 14/stepping 8) will be supported by
either speedstep, P4 or ACPI driver?   NONE of these work.  P4 did work
briefly (-rc1-git4 and -rc1-git6) but I'm not sure that it's optimal.
acpi-cpufreq hasn't loaded since 2.6.18  (which didn't work properly
with other parts of the laptops so went with 2.6.19 rc series).
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFPokhbFT/SAfwLKMRAgFrAKCS/3jAVs12uk2LWhAcN/vFZe7nvACfeLr2
EJOWO0HZ4hVk3UXZoxe4BbQ=
=wO+m
-----END PGP SIGNATURE-----
