Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129491AbRB0Cc6>; Mon, 26 Feb 2001 21:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129501AbRB0Ccp>; Mon, 26 Feb 2001 21:32:45 -0500
Received: from boreas.isi.edu ([128.9.160.161]:10703 "EHLO boreas.isi.edu")
	by vger.kernel.org with ESMTP id <S129491AbRB0CcC>;
	Mon, 26 Feb 2001 21:32:02 -0500
To: michael@linuxmagic.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [UPDATE] zerocopy.. While working on ip.h stuff 
In-Reply-To: Your message of "Mon, 26 Feb 2001 17:53:30 PST."
             <0102261753300I.02007@mistress> 
Date: Mon, 26 Feb 2001 18:31:59 -0800
Message-ID: <18431.983241119@ISI.EDU>
From: Craig Milo Rogers <rogers@ISI.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> a competing philosophy that said that the IP checksum must be
>> recomputed incrementally at routers to catch hardware problems in the
...
>ah.. we do recalculate IP Checksums now..  when we update any of the 
>timestamp rr options etc..

	But, do you do it incrementally? By which I mean: subtract
(appropriately) the old value of the octet from the existing checksum,
field in the packet then add (appropriately) the new value of the
octet to the checksum?  Simply recalculating the IP checksum from
scratch can generate a "correct" checksum for a packet that was
damaged*** while waiting around in memory.

	I don't know if people worry about this now, but 20 years ago
there was a fuss about it.  Further discussion offline, please.

					Craig Milo Rogers
	
*** Maybe by hardware trouble, or maybe because someone followed a bad
    pointer and stomped on part of the header.
