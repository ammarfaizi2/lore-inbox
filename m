Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129216AbQKENIO>; Sun, 5 Nov 2000 08:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129200AbQKENIE>; Sun, 5 Nov 2000 08:08:04 -0500
Received: from 3dyn134.com21.casema.net ([212.64.94.134]:29190 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S129257AbQKENH4>;
	Sun, 5 Nov 2000 08:07:56 -0500
Date: Sun, 5 Nov 2000 15:01:55 +0100
From: bert hubert <ahu@ds9a.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: Loadavg calculation
Message-ID: <20001105150155.A17251@home.ds9a.nl>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0011050746090.634-100000@juryrig.worldnet.att.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre4i
In-Reply-To: <Pine.LNX.4.21.0011050746090.634-100000@juryrig.worldnet.att.net>; from bobyetman@att.net on Sun, Nov 05, 2000 at 07:55:40AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05, 2000 at 07:55:40AM -0500, bobyetman@att.net wrote:

> The other option we looked at, besides using loadavg, was using idle pct%,
> but if I read the source for top right, involves reading the entire
> process table to calculate clock ticks used and then figuring out how many
> weren't used.

Snoop the source of vmstat, it measures the amount of programs in the run
queue, which is how the load average is calculated. You do need to average
this data in order for it to be useful.

You might also follow /proc/uptime, which gives the number of jiffies the
system has been up, and how many jiffies have been spent by the idle task.
If you take the derivative if the idle jiffies, you get the percentage idle
time.

You might also try to measure directly how much time is spent in the idle
task (0).

Regards,

bert hubert

-- 
PowerDNS                     Versatile DNS Services  
Trilab                       The Technology People   
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
