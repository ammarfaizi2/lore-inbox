Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313038AbSD3DAu>; Mon, 29 Apr 2002 23:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313041AbSD3DAt>; Mon, 29 Apr 2002 23:00:49 -0400
Received: from bstnma1-ar1-4-64-205-250.bstnma1.elnk.dsl.genuity.net ([4.64.205.250]:28670
	"EHLO mail.spoofed.org") by vger.kernel.org with ESMTP
	id <S313038AbSD3DAs>; Mon, 29 Apr 2002 23:00:48 -0400
Date: Mon, 29 Apr 2002 23:04:18 -0400
From: warchild@spoofed.org
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: remote memory reading using arp?
Message-ID: <20020430030418.GB6179@spoofed.org>
In-Reply-To: <p73znzom2kv.fsf@oldwotan.suse.de> <Pine.LNX.4.33L2.0204291121420.26604-100000@rtlab.med.cornell.edu> <20020429173144.A4044@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings again,

I took the time today to gather as much arp traffic as my eyes could handle and
enough to shed some valuable light on this issue.

While it doesn't show who/what is at fault, it may possibly prove that I'm
missing something entirely or the problem is more widespread that was
thought.

Anyway, here goes.   

For test 1, I gathered ~1.5M of arp traffic from a monitoring port that
sustains 4-5Mb/s traffic in a mixed solaris/linux/win2k environment of
approximately 400 machines in an educational setting.

For test 2, I gathered ~.5M of arp traffic from a single interface of a
RedHat machine located in a "Small Business" environment consisting of
approximately 25 machines (linux/winXP).  

That much arp data is pretty unruly, so I used grep to see if anything
stuck out.  

I grepped for our domain name (ccs.neu.edu) and found this string 15 times in
test 1, and grepped for 'http' in test 2 and found that string 62 times.

Upon digging into the traffic a bit further, I saw an interesting trends.
All of the arp packets that contained interesting data contained it in the
last 18 bytes of the 60 byte arp packet.  After googling and browsing the
rfcs, I've seen these last 18 bytes referred to as both 'trailers' and
'padding'.  It is not clear to me what purpose they serve, but seems clear
that they can contain some potentially sensitive data.  

I know this may be getting a bit off topic, but I figured I share my
findings with the lists.  If I am incorrect in any of my statements, please
correct me.

thanks,

-jon 
