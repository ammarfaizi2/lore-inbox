Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135871AbRDTLeJ>; Fri, 20 Apr 2001 07:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135872AbRDTLeA>; Fri, 20 Apr 2001 07:34:00 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:32457 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S135871AbRDTLds>;
	Fri, 20 Apr 2001 07:33:48 -0400
Message-ID: <3AE01E97.E41399F7@mandrakesoft.com>
Date: Fri, 20 Apr 2001 07:33:43 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: stefan@jaschke-net.de
Cc: Oliver Teuber <teuber@core.devicen.de>, linux-kernel@vger.kernel.org,
        epic@skyld.com
Subject: Re: epic100 error
In-Reply-To: <20010417184552.A6727@core.devicen.de> <01042013091501.07156@antares>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Jaschke wrote:
> I also noted that there are substantial differences between the original epic100.c at
> http://www.scyld.com/network/epic100.html and the version included with 2.4.3.
> Who did these changes?

Francois (PCI DMA) and me (everything else).  The scyld version does not
support 2.4 kernels, so these changes were necessary.

Besides Francois changes, the biggest thing in 2.4.3 was a merge of
additional scyld.com code :)

I'm leaving on a trip so I won't be able to look at this until after
2.4.4 is released...   Maybe one of you guys is willing to play patch
circus, and go through the changes to the epic driver one by one and see
which one caused the breakage.  When I get back I'll take a look at
this.

Here's a suggestion to try: go through epic100.c and write 0x12
unconditionally to MIICfg register.  Right now it is conditional:  if
(dev->if_port...) out(0x12,ioaddr+MIICfg);

-- 
Jeff Garzik      | The difference between America and England is that
Building 1024    | the English think 100 miles is a long distance and
MandrakeSoft     | the Americans think 100 years is a long time.
                 |      (random fortune)
