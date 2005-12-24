Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422660AbVLXK6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422660AbVLXK6A (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 05:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422661AbVLXK6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 05:58:00 -0500
Received: from www.tuxrocks.com ([64.62.190.123]:31251 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S1422660AbVLXK6A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 05:58:00 -0500
Message-ID: <43AD29A6.10407@tuxrocks.com>
Date: Sat, 24 Dec 2005 03:57:42 -0700
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc Koschewski <marc@osknowledge.org>
CC: Joe Feise <jfeise@feise.com>, linux-kernel@vger.kernel.org,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: mouse issues in 2.6.15-rc5-mm series
References: <43ACEE14.7060507@feise.com> <20051224104224.GA5789@stiffy.osknowledge.org>
In-Reply-To: <20051224104224.GA5789@stiffy.osknowledge.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Marc Koschewski wrote:
> * Joe Feise <jfeise@feise.com> [2005-12-23 22:43:32 -0800]:
> 
> 
>>[Note: please cc me on answers since I'm not subscribed to the kernel list]
>>
>>I am experiencing problems with mouse resyncing in the -mm series.
>>This is a Logitech wheel mouse connected through a KVM.
>>Symptom: whenever the mouse isn't moved for some seconds, it doesn't
>>react to movement for a second, and then resyncs. Sometimes, the
>>resyncing results in the mouse pointer jumping, which as far as I
>>know is a protocol mismatch.
>>While searching for reports of similar problems, I came across
>>Frank Sorenson's post from Nov. 23 (http://lkml.org/lkml/2005/11/23/533).
>>Like in his case, reverting
>>input-attempt-to-re-synchronize-mouse-every-5-seconds.patch
>>resulted in a kernel without this problem.
>>
>>-Joe

Joe,

I continue to see the same issues with the resync patch in -mm.  For me,
tapping stops working, and I'm now seeing both the mouse pointer jumping
 as well (a lesser issue for me, so it was probably present earlier as
well).

I switched to using the synaptics X driver as recommended by Dmitry
Torokhov (http://lkml.org/lkml/2005/11/25/130), and that has worked
splendidly for me.  However, that's really just a band-aid, and I'd be
happier with a working resync patch.

> Hi Joe,
> 
> read these ones:
> 
> http://lkml.org/lkml/2005/11/18/152
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0511.3/0019.html
> 
> Maybe they help you out.
> 
> I didn't get it working in the rc5 -mm tree so far. But non -mm work as good as
> they always did.

Same issue for me as well.

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDrSmmaI0dwg4A47wRAidbAJ9rR7ZtgavKNw1aEamcdZ8Br/27GwCdEQcc
JHP9CL6TTlbhYm8kyzeXH+w=
=w3cG
-----END PGP SIGNATURE-----
