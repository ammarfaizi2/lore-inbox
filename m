Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317544AbSFMIvd>; Thu, 13 Jun 2002 04:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317552AbSFMIvc>; Thu, 13 Jun 2002 04:51:32 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:24070 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S317544AbSFMIva>; Thu, 13 Jun 2002 04:51:30 -0400
Message-ID: <3D085D07.4DC40FF3@aitel.hist.no>
Date: Thu, 13 Jun 2002 10:51:19 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.20-dj3 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONFIG_NR_CPUS, redux
In-Reply-To: <Pine.LNX.4.44.0206111917310.3521-100000@sharra.ivimey.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ruth Ivimey-Cook wrote:

> Perhaps it's just because I'm coming in late, but I cannot understand why
> NR_CPUS cannot be as low as 4 by default, for all archs, and then in the
> kernel boot messages, should more be found than is configured for a message is
> emitted to say "reconfigure your kernel", and continue with the number it was
> configured for. I personally only rarely see 2-way boxes, 4-way is pretty
> rare, and anything more must surely count as very specialized.
> 
Why not let the boot process select the highest of two numbers,
the (default-low) NR_CPUS and the number of CPU's detected?

Boot with "too many" cpu's and you still get to use them - you
merely can't hotplug even more.  

Configuring a high NR_CPUS becomes something only hot-pluggers
need to do, or those whose architecture doesn't support
cpu detection in the early boot process.  Those with a fixed
number of detectable CPUs can simply go with a default of 
NR_CPUS=2 no matter what they actually have.

Helge Hafting
