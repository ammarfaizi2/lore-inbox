Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292239AbSB0O13>; Wed, 27 Feb 2002 09:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292515AbSB0O1U>; Wed, 27 Feb 2002 09:27:20 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:27304 "HELO
	outpost.powerdns.com") by vger.kernel.org with SMTP
	id <S292406AbSB0O1K>; Wed, 27 Feb 2002 09:27:10 -0500
Date: Wed, 27 Feb 2002 15:27:05 +0100
From: bert hubert <ahu@ds9a.nl>
To: Bjorn Wesen <bjorn.wesen@axis.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What is TCPRenoRecoveryFail ?
Message-ID: <20020227152705.A18366@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Bjorn Wesen <bjorn.wesen@axis.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1020227144128.18713E-100000@fafner.axis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.96.1020227144128.18713E-100000@fafner.axis.se>; from bjorn.wesen@axis.com on Wed, Feb 27, 2002 at 01:46:55PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2002 at 01:46:55PM +0000, Bjorn Wesen wrote:
> I have a TCP connection that is sending bulk data from a Linux 2.4.17
> machine to a client. At some point, one of the packets from the Linux
> machine is lost, so the client asks for a retransmit by acking the last
> received correct packet. Then the Linux machine just keeps filling the
> clients open window, ignoring that and subsequent retransmit requests,
> never retransmitting any data.

Please show a tcpdump -v of this happening, including the initial SYN
packets. I strongly suspect something in your network of mucking with TCP
options.

> Around the time of the packet loss happened, the counter
> TCPRenoRecoveryFail increased by one, but I'm not sufficiently into the
> TCP code to figure out why that happens and if that is the reason why
> Linux stop retransmitting anything.. any ideas ?

See RFC2001. Might well be related.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
