Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262707AbRFMNuU>; Wed, 13 Jun 2001 09:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263149AbRFMNuK>; Wed, 13 Jun 2001 09:50:10 -0400
Received: from ns.suse.de ([213.95.15.193]:4874 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S262707AbRFMNtx>;
	Wed, 13 Jun 2001 09:49:53 -0400
Date: Wed, 13 Jun 2001 15:49:51 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: Magnus Sandberg <Magnus.Sandberg@bluelabs.se>
Cc: <arjanv@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Changing CPU Speed while running Linux
In-Reply-To: <20010613134111.B126C17C7@mailrelay.bluelabs.se>
Message-ID: <Pine.LNX.4.30.0106131544410.19499-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2001, Magnus Sandberg wrote:

> I have a brand new Dell Inspiron 8000, laptop. It can run in 700 MHz or
> 850 MHz. The manual says that the machine/BIOS switches speed dependent on
> CPU load. I have not installed Linux yet, but it works with Win2000.

Intel Speedstep iirc. My Vaio also has it. My findings so far:

On mains it runs at 700MHz, whilst on batteries it drops to ~550MHz.
If I boot an ACPI enabled kernel, the speed changes according to CPU
load, but with a smaller window. I've seen it go as low as 50MHz,
but only up to a maximum of 200MHz.   The fact that it only has a maximum
of 200MHz in this mode probably explains the need for the no-idle switch
in the current ACPI implementation.

As there are no public documents on Speedstep, it's not clear to me
whether this is a limitation of Speedstep, or the ACPI implementation.
Judging by the fact that Windows seems to run at full speed, I'd
be inclined to think the latter.

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

