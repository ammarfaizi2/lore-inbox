Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAJBtg>; Tue, 9 Jan 2001 20:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129903AbRAJBt0>; Tue, 9 Jan 2001 20:49:26 -0500
Received: from ns1.megapath.net ([216.200.176.4]:30479 "EHLO megapathdsl.net")
	by vger.kernel.org with ESMTP id <S129431AbRAJBtP>;
	Tue, 9 Jan 2001 20:49:15 -0500
Message-ID: <3A5BBF5A.7030103@megapathdsl.net>
Date: Tue, 09 Jan 2001 17:48:10 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-ac1 i686; en-US; m18) Gecko/20010107
X-Accept-Language: en
MIME-Version: 1.0
To: rob@sysgo.de
CC: linux-kernel@vger.kernel.org
Subject: Re: Anybody got 2.4.0 running on a 386 ?
In-Reply-To: <Pine.LNX.4.21.0101100527220.23018-100000@bee.lk> <01011000420402.03050@rob>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Just out of curiosity, did you use a 2.2 series
.config file and then run make oldconfig or did
you build a new .config file from scratch?

I have periodically built kernels that crashed
immediately at the point you mention.  Usually this
was due to me choose configuration options that
were incompatible with my machine's hardware.

Another time, the machine wouldn't boot because
I needed a new version of LILO.  I also have seen
at least one machine where I needed to specify
"linear" as one of the options in lilo.conf.
If you aren't specifying "linear" now, give it
a try.

IIRC, here's my litany of goofed configurations:

	Building support for multiple framebuffer
	devices.  Apparently, the kernel would
	hang in the chip detection process.

	Wrong CPU architecture.

	Wrong IDE chipset specified.

	Built EXT2 as a module, but / was on
	an EXT2 partition.

I may have hit some other bogus configurations
over the last two years, but these are ones that
come to mind.

	Miles

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
