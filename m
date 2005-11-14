Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbVKNXHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbVKNXHd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 18:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbVKNXHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 18:07:33 -0500
Received: from www.tuxrocks.com ([64.62.190.123]:2825 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S932233AbVKNXHc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 18:07:32 -0500
Message-ID: <437918A0.8000308@tuxrocks.com>
Date: Mon, 14 Nov 2005 16:07:12 -0700
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Darren Hart <dvhltc@us.ibm.com>, Nishanth Aravamudan <nacc@us.ibm.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/13] Time: Generic Timeofday Subsystem (v B10)
References: <20051112044850.8240.91581.sendpatchset@cog.beaverton.ibm.com>	 <4378FFFF.4010706@tuxrocks.com> <1132004327.4668.30.camel@leatherman>	 <4379074D.5060308@tuxrocks.com> <1132005736.4668.34.camel@leatherman>
In-Reply-To: <1132005736.4668.34.camel@leatherman>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

john stultz wrote:
> On Mon, 2005-11-14 at 14:53 -0700, Frank Sorenson wrote:
> 
>>-----BEGIN PGP SIGNED MESSAGE-----
>>Hash: SHA1
>>
>>john stultz wrote:
>>
>>>Hmm... Not sure if this is mis-calibration or just bad-interaction w/
>>>kthrt. Mind sending a dmesg to me?

Okay, the c3tsc clock drift is definitely not an interaction with kthrt.
 Here is 2.6.14-mm2 + the TOD B10 patches:
14 Nov 15:54:52   offset: -0.003031       drift: -3091.0 ppm
14 Nov 15:55:52   offset: -0.184073       drift: -3018.57377049 ppm
14 Nov 15:56:52   offset: -0.345268       drift: -2853.95041322 ppm
14 Nov 15:57:53   offset: -0.463002       drift: -2544.2967033 ppm
14 Nov 15:58:53   offset: -0.587743       drift: -2428.93801653 ppm

Running just 2.6.14-mm2 + TOD B10, I seem to be unable to reproduce the
Badness errors, and the clocksource has not frozen at one setting.

I can provide a dmesg if needed.

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDeRigaI0dwg4A47wRAsv6AJ4sPwUMg44sRN+kGpYjKjF8+qZWIACfZ1YL
pLHKnEHkMjMi32kGWeT+gEw=
=9hHi
-----END PGP SIGNATURE-----
