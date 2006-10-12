Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932639AbWJLPpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932639AbWJLPpA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 11:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932636AbWJLPpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 11:45:00 -0400
Received: from rwcrmhc13.comcast.net ([204.127.192.83]:21635 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S932644AbWJLPo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 11:44:59 -0400
Message-ID: <452E62F8.5010402@comcast.net>
Date: Thu, 12 Oct 2006 11:44:56 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Can context switches be faster?
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Can context switches be made faster?  This is a simple question, mainly
because I don't really understand what happens during a context switch
that the kernel has control over (besides storing registers).

Linux ported onto the L4-Iguana microkernel is reported to be faster
than the monolith[1]; it's not like microkernels are faster, but the
L4-Iguana apparently just has super awesome context switching code:

   Wombat's context-switching overheads as measured by lmbench on an
   XScale processor are up to thirty times less than those of native
   Linux, thanks to Wombat profiting from the implementation of fast
   context switches in L4-embedded.

The first question that comes into my mind is, obviously, is this some
special "fast context switch" code for only embedded systems; or is it
possible to work this on normal systems?

The second is, if it IS possible to get faster context switches in
general use, can the L4 context switch methods be used in Linux?  I
believe L4 is BSD licensed-- at least the files in their CVS repo that I
looked at have "BSD" stamped on them.  Maybe some of the code can be
examined, adopted, adapted, etc.

If it's not possible to speed up context switches, the classical
question would probably be.. why not?  ;)  No use knowing a thing and
not understanding it; you get situations like this right here... :)

[1]http://l4hq.org/
- --
    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRS5i9ws1xW0HCTEFAQKHtw/+PtjvtkfynX0uItgpa2zocbo8/hadu4kp
dGmxI9eBouUc0T5GDjX7hHYolaIFswuNWyrnELU6uE4WeQ6l5BFnobc1FCiHLVBE
7cZlr9FaFw3r7Ohb4AJBTLKXRYP3h107SnccxJLcqVqspwmzs6lZHaXCU9vrxpCW
Xaam8bSBUrqJ3tIPalM20Nl4SrVF0clMYlKRT2LdD3/TFdN2e60m9sczyGEnLVT/
Co+/JpQ5qxk7DqjXJHr0N5a0CmgjlTZQHEjtvfcPlrKa5CprLECrYx2aJHgs+nIz
CXf9L2z3oiE4yWADK5+zXlJWcF7+pvspIsI9rQDdHoO2xFUzguiVup9XJOLbytpV
yN0dVrOWaAXQMBtrYCInOtA6ynpAZ+hTv2EBSHRaOC+mnxcDTBSqJrj979RrKGlj
Mz282LaSRDL4XPq9d8LwrnuPHIoqGGfj0wUKwmxC19vDfGOk3Y1I/frvcRgnjlb1
TwG/QPgiGcXXVTgEDeogqgq+DRPmuoxxXo+OPMgA4441BzgqkCzxmjLA0uQL15dd
CrAO8NF1fOzvWCvAQO8DhSaGGOikeur4BdkwnF6/eTQYA7QGewaCVdY0u6Q2dhAF
wrGho4pGaEh/ev59/KsHvtSD88SfTUsLigTgGrwiRTufUm4XVbr5AzldTPUMUkUU
+jRWrqbwkLM=
=IDvt
-----END PGP SIGNATURE-----
