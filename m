Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264969AbUD2Um7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264969AbUD2Um7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 16:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264966AbUD2Um0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 16:42:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:48265 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264969AbUD2Ubv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 16:31:51 -0400
X-Authenticated: #4512188
Message-ID: <40916638.2040202@gmx.de>
Date: Thu, 29 Apr 2004 22:31:52 +0200
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040413)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesse Allen <the3dfxdude@hotmail.com>
CC: Ross Dickson <ross@datscreative.com.au>, Len Brown <len.brown@intel.com>,
       a.verweij@student.tudelft.nl, Craig Bradney <cbradney@zip.com.au>,
       christian.kroener@tu-harburg.de, linux-kernel@vger.kernel.org,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jamie Lokier <jamie@shareable.org>, Daniel Drake <dan@reactivated.net>,
       Ian Kumlien <pomac@vapor.com>, Allen Martin <AMartin@nvidia.com>
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
 for idle=C1halt, 2.6.5
References: <Pine.GHP.4.44.0404271807470.6154-100000@elektron.its.tudelft.nl> <200404282133.34887.ross@datscreative.com.au> <20040428205938.GA1995@tesore.local> <200404292144.37479.ross@datscreative.com.au> <20040429202413.GA1982@tesore.local>
In-Reply-To: <20040429202413.GA1982@tesore.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Allen wrote:
> What I'd like to know is where the sound chip is really at on my board.  I've 
> tried looking before, but find myself confused.
> 
> A pic:
> http://us.shuttle.com/images/productimages/AN35.jpg
> 
> According to a diagram that I have, it points to an AC'97 6-CH AUDIO as a chip
> near of the top of the board in the image that I link to, above 2nd PCI slot 
> left of the AGP.  But I'm am also left thinking, how does the NForce2 MCP come 
> into play.  Specs would help.  Maybe if we can figure out how the sound is 
> wired on the board, we could also trace the source of noise to the exact 
> component.

Yes, I also think the chip above 2nd PCI slot is the right one. You can 
see the realtek logo. It is only a ac97 codec (basically not more than a 
DAC and ADC) and linux currently only has drivers for this. The MCP-T 
has an APU, which could do dsp stuff by hardware, but no drivers still 
(Hello Nvidia?), so all of this is done via software. (THe APU has even 
more functionality, like DD5.1 realtime encoding, fx, and whatever). In 
our case, the APU shouldn't cause any troubles, as it is not used. With 
the APU, nforce2 chipset behaves like a "real" soundcard. Without, its 
sound abilities are not better than the average mainboard's onboard sound.

Prakash
