Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289216AbSAVKDH>; Tue, 22 Jan 2002 05:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289222AbSAVKCs>; Tue, 22 Jan 2002 05:02:48 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:17417 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S289219AbSAVKCi>; Tue, 22 Jan 2002 05:02:38 -0500
Date: Tue, 22 Jan 2002 10:02:30 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Dan Chen <crimsun@email.unc.edu>
Cc: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.18pre4aa1
Message-ID: <20020122100230.B20650@flint.arm.linux.org.uk>
In-Reply-To: <20020122074806.A1547@athlon.random> <1011682739.17096.563.camel@phantasy> <20020122073742.GA767@opeth.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020122073742.GA767@opeth.ath.cx>; from crimsun@email.unc.edu on Tue, Jan 22, 2002 at 02:37:42AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2002 at 02:37:42AM -0500, Dan Chen wrote:
> No weird anomalies here. I believe the ones you refer to were a result
> of ipv6 bits not being updated as well. Russell posted two patches for
> those.

No - I do see weirdness in ipv4 as well:

bash-2.04# uptime
 10:00am  up 18:57,  1 user,  load average: 0.02, 0.03, 0.00
bash-2.04# dmesg|grep 'broad'
127.0.0.1 sent an invalid ICMP error to a broadcast.
127.0.0.1 sent an invalid ICMP error to a broadcast.
127.0.0.1 sent an invalid ICMP error to a broadcast.
127.0.0.1 sent an invalid ICMP error to a broadcast.
127.0.0.1 sent an invalid ICMP error to a broadcast.
127.0.0.1 sent an invalid ICMP error to a broadcast.
127.0.0.1 sent an invalid ICMP error to a broadcast.
127.0.0.1 sent an invalid ICMP error to a broadcast.
127.0.0.1 sent an invalid ICMP error to a broadcast.
127.0.0.1 sent an invalid ICMP error to a broadcast.
127.0.0.1 sent an invalid ICMP error to a broadcast.
127.0.0.1 sent an invalid ICMP error to a broadcast.

Only one of these happened on boot.  The rest randomly pop up over time.
I'm going to try tcpdumping lo to see if I can work out what's causing
them.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

