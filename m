Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263607AbUDFD2o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 23:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263611AbUDFD2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 23:28:44 -0400
Received: from scrye.com ([216.17.180.1]:34517 "EHLO mail.scrye.com")
	by vger.kernel.org with ESMTP id S263607AbUDFD2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 23:28:41 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Mon, 5 Apr 2004 21:28:34 -0600
From: Kevin Fenzi <kevin@scrye.com>
To: linux-kernel@vger.kernel.org
X-Mailer: VM 7.17 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Subject: Re: 2.6.5, ACPI, suspend and ThinkPad R40
X-Draft-From: ("scrye.linux.kernel" 27756)
References: <20040404173646.GA15635@puck.ch>
	<40708569.7060403@stud.feec.vutbr.cz> <20040405221940.GA17419@puck.ch>
Message-Id: <20040406032837.6B4DB1100E@voldemort.scrye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>>>>> "Olivier" == Olivier Bornet <Olivier.Bornet@puck.ch> writes:

Olivier> Hi,
Olivier> On Mon, Apr 05, 2004 at 12:00:09AM +0200, Michal Schmidt wrote:
>> Yes, see: http://bugzilla.kernel.org/show_bug.cgi?id=1415 There is
>> a patch which worked for me.

Olivier> Thanks a lot. :-) This patch is working as expected for
Olivier> me. Now, after doing a:

Olivier>   echo LID > /proc/acpi/wakeup_devices echo SLPB >
Olivier> /proc/acpi/wakeup_devices

Olivier> I can resume by opening the laptop, or by using the Fn
Olivier> button, or by using the power button. :-)

Alas, I would like to report it doesn't work for me. 

My laptop suspends, but never comes back from suspend as well. 
It doesn't seem like the LID or power buttons are a possible setting
for me. Doing a 'cat /proc/acpi/wakeup_devices' gives:

Device  Speep state     Status
C04E       5            disabled
C0A0       3            disabled
C0A6       3            disabled
C0A9       3            disabled
C161       3            disabled
C162       3            disabled
C177       4            disabled
C11E       4            disabled

C11E is my suspend button, but it doesn't seem like it will allow S3? 
I have no idea what the other addresses are. I tried enabling them
all, and got a big pile of oopses (which I can duplicate if anyone
wants)

Any ideas?

Olivier> This patch seems "very" old (first release 2003-10-28).

Olivier> Anyone know why this patch is not in the kernel source tree
Olivier> at this time ?

Yeah, if it helps some people then it should go in I would think. 

It would be nice if we could just set the list of wakeup devices to a
sane list for everyone tho. Power/lid/suspend button. 

Back to using nigels swsusp2... at least it's quite fast and the
latest one seems pretty stable with 2.6 for me at least. ;) 

kevin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQFAciPl3imCezTjY0ERApkWAJ4xZFmTDgXsq7cvrXOQ/HR70Fs5PQCeJshD
uc1kiMwhqGUhn0fDD7FDHko=
=E51X
-----END PGP SIGNATURE-----
