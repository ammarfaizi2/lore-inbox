Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261356AbREMUzI>; Sun, 13 May 2001 16:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261886AbREMUy6>; Sun, 13 May 2001 16:54:58 -0400
Received: from 20dyn175.com21.casema.net ([213.17.90.175]:38926 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S261356AbREMUyt>;
	Sun, 13 May 2001 16:54:49 -0400
Date: Sun, 13 May 2001 22:54:15 +0200
From: bert hubert <ahu@ds9a.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux TCP impotency
Message-ID: <20010513225415.A4950@home.ds9a.nl>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010513213853.A5700@ghost.btnet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre4i
In-Reply-To: <20010513213853.A5700@ghost.btnet.cz>; from clock@ghost.btnet.cz on Sun, May 13, 2001 at 09:38:53PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2001 at 09:38:53PM +0200, clock@ghost.btnet.cz wrote:
> Using 2.2.19 I discovered that running two simultaneous scp's (uses up whole
> capacity in TCP traffic) on a 115200bps full duplex serial port nullmodem cable
> causes the earlier started one to survive and the later to starve. Running bcp
> instead of the second (which uses UDP) at 11000 bytes per second caused the
> utilization in both directions to go up nearly to 100%.
> 
> Is this a normal TCP stack behaviour?

Might very well be. Read about different forms of (class based) queuing
which try (and succeed) to improve IP in this respect. TCP is not fair and
IP has no intrinsic features to help you. http://ds9a.nl/2.4Routing contains
some explanations and links.

SFQ sounds like it might fit your bill.

Regards,

bert

-- 
http://www.PowerDNS.com      Versatile DNS Services  
Trilab                       The Technology People   
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
