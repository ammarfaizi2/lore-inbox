Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264359AbUD0VbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264359AbUD0VbZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 17:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264360AbUD0VbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 17:31:25 -0400
Received: from mail.gmx.de ([213.165.64.20]:43712 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264359AbUD0VbX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 17:31:23 -0400
X-Authenticated: #4512188
Message-ID: <408ED126.4030608@gmx.de>
Date: Tue, 27 Apr 2004 23:31:18 +0200
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040413)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ross@datscreative.com.au
CC: Len Brown <len.brown@intel.com>, Jesse Allen <the3dfxdude@hotmail.com>,
       Craig Bradney <cbradney@zip.com.au>, christian.kroener@tu-harburg.de,
       linux-kernel@vger.kernel.org, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jamie Lokier <jamie@shareable.org>, Daniel Drake <dan@reactivated.net>,
       Ian Kumlien <pomac@vapor.com>, a.verweij@student.tudelft.nl,
       Allen Martin <AMartin@nvidia.com>
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
 for idle=C1halt, 2.6.5
References: <200404131117.31306.ross@datscreative.com.au> <20040422163958.GA1567@tesore.local> <1082654469.16333.351.camel@dhcppc4> <200404262141.24616.ross@datscreative.com.au>
In-Reply-To: <200404262141.24616.ross@datscreative.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have just made soem interesting experience. It seems Len's timer 
routing patch (or whatever you wanna call it) stabilizes my system to a 
certain amount or NOT using AGP stabilizes it to an amount...

The whole story: I am using Ross' C1halt patch to make the system stable 
in APIC mode, but due to a recent change I borked my kernel parameters 
and just had idle=halt instead of idle=C1halt as parameter, thus I had 
not activated Ross patch by accident. Nevertheless, the system survived 
a whole day! Usually it locks up within minutes, but this time no. I 
even did yome heavy copying from DVD to HD and from one HD to another 
with peaks of about 40mb/s. Finally the system crashed when I recorded 
from dvb to hd (but only after 20minutes). Then after a reboot (still 
NOT using Ross' patch) it survived dvb recording for about 30min.

I only manage to instantly lock the system when doing a hdparm (rather a 
second hdparm, the first one gives just about 20mb/sec, hello Jeff? What 
is libata doing here?) which goes up to >60mb/sec.

So Len, maybe try using a faster hd to crash your shuttle if it is one 
of the borked bioses...

As I used the open source NV driver all the time, AGP probably wasn't in 
use (or someone tell me how to use AGP with nv driver...), as ususally 
without Ross' patches using AGP I get fast lock-ups or as stated above 
Len's patch makes it a bit better. In fact I would need to try Len's 
patch and AGP on (with nvidia binary) to find out whether agp or Len's 
patch makes the difference. But currently I am too tired and not in the 
mood to further patch current mm-kernel to get Nvidia's binary running 
again...

Does anybody know a tool to generate certain amount of traffic on PCI 
bus? So I could test at which point the system wants to lock-up now. 
Only idea I have right now is to put an older hd into the system an test.

bye,

Prakash
