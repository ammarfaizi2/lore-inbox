Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbUJAQE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUJAQE6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 12:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbUJAQE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 12:04:57 -0400
Received: from scrye.com ([216.17.180.1]:11462 "EHLO mail.scrye.com")
	by vger.kernel.org with ESMTP id S264098AbUJAQEN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 12:04:13 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Fri, 1 Oct 2004 10:03:29 -0600
From: Kevin Fenzi <kevin-linux-kernel@scrye.com>
To: linux-kernel@vger.kernel.org
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Subject: Re: 2.6.9-rc3 software suspend (pmdisk) stopped working
X-Draft-From: ("scrye.linux.kernel" 72391)
References: <415C2633.3050802@0Bits.COM> <20041001102351.GC18786@elf.ucw.cz>
Message-Id: <20041001160333.1D229774C3@voldemort.scrye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>>>>> "Pavel" == Pavel Machek <pavel@ucw.cz> writes:

Pavel> Hi!
>> Anyone noticed that pmdisk software suspend stopped working in -rc3
>> ?  In -rc2 it worked just fine. My script was
>> 
>> chvt 1 echo -n shutdown >/sys/power/disk echo -n disk
>> >/sys/power/state chvt 7
>> 
>> In -rc3 it appears to write pages out to disk, but never shuts down
>> the machine. Is there something else i need to do or am missing ?

Pavel> You are not missing anything, it is somehow broken. I'll try to
Pavel> find out what went wrong and fix it. In the meantime, look at
Pavel> -mm series, it works there.  Pavel 

I finally had a chance to try 2.6.9-rc3 here last night. 

It suspended ok for me, but on resume it would load in the cache and
then reboot. :(

kevin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQFBXX/V3imCezTjY0ERAg41AJ4/F7ZyFibY0ZNk465IA04AXZnt3gCeNglf
HMbMUrmAEhkvkwbjP4RRqdU=
=BxrI
-----END PGP SIGNATURE-----
