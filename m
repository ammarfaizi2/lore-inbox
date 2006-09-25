Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWIYISH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWIYISH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 04:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbWIYISH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 04:18:07 -0400
Received: from ironport-c10.fh-zwickau.de ([141.32.72.200]:51024 "EHLO
	ironport-c10.fh-zwickau.de") by vger.kernel.org with ESMTP
	id S1750722AbWIYISD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 04:18:03 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAALMsF0WLcQEBDQ
X-IronPort-AV: i="4.09,211,1157320800"; 
   d="scan'208"; a="3463212:sNHT33653644"
Date: Mon, 25 Sep 2006 10:18:00 +0200
From: Joerg Roedel <joro-lkml@zlug.org>
To: David Miller <davem@davemloft.net>
Cc: hadi@cyberus.ca, jbglaw@lug-owl.de, kaber@trash.net,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 00/03][RESUBMIT] net: EtherIP tunnel driver
Message-ID: <20060925081800.GA23028@zlug.org>
References: <20060923120704.GA32284@zlug.org> <20060923121327.GH30245@lug-owl.de> <1159015118.5301.19.camel@jzny2> <20060923.163535.41636370.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060923.163535.41636370.davem@davemloft.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2006 at 04:35:35PM -0700, David Miller wrote:

> First, the only mentioned real use of EtherIP I've seen anywhere is to
> tunnel old LAN based games that used protocols other than IP :-)

Thats an important use case for EtherIP, thats right :-)
But people often use Ethernet over IP tunneling to transparently switch
between wired and wireless network connections on laptops (and secure
the WLAN path with IPSEC).
Xen also implements the EtherIP protocol in their vnet module.

> Second, the OpenBSD interoperability issues are very real, and there
> is even a Xerox implementation that used an 8-bit instead of a 16-bit
> header size.

Ok, I don't know if the Xerox implementation is still in use anywhere. I
can't find anything in the web about it. But it is mentioned in the RFC,
thats right. The interoperability issue with the BSDs is real. At least
of NetBSD I know that its implementation does not check the incoming
header because of that issue. My implementation also avoids this check.

> Third, even the introductory material in RFC3378 mentions that people
> are strongly encouraged to use other technologies over EtherIP.

Yes, thats right.

> Fourth, and finally, if GRE can provide the same functionality then
> that plus the first three points makes EtherIP something we really
> should not latch onto.

GRE additionally provides interoperability with some hardware devices.
But it does not provide compatibility to the BSDs.

> And if it doesn't go in, it's not the end of the world.  Anyone can
> maintain and use the external patch, and if usage gets widespread
> enough we'll of course be required to reevaluate integration.

Ok. I will maintain the driver outside the kernel for the next time.
Lets see if there are enough users for it :)

Cheers,
Joerg
