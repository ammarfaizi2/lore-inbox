Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282933AbRLCIsh>; Mon, 3 Dec 2001 03:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282997AbRLCIsQ>; Mon, 3 Dec 2001 03:48:16 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:43417 "HELO
	outpost.powerdns.com") by vger.kernel.org with SMTP
	id <S284606AbRLCCAE>; Sun, 2 Dec 2001 21:00:04 -0500
Date: Mon, 3 Dec 2001 03:00:02 +0100
From: bert hubert <ahu@ds9a.nl>
To: lartc@mailman.ds9a.nl, linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru,
        hadi@cyberus.ca, netdev@oss.sgi.com
Subject: CBQ and all other qdiscs now REALLY completely documented (almost!)
Message-ID: <20011203030002.A20601@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, lartc@mailman.ds9a.nl,
	linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru, hadi@cyberus.ca,
	netdev@oss.sgi.com
In-Reply-To: <20011201013341.A23830@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011201013341.A23830@outpost.ds9a.nl>; from ahu@ds9a.nl on Sat, Dec 01, 2001 at 01:33:41AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 01, 2001 at 01:33:41AM +0100, bert hubert wrote:

> One thing - does *anybody* understand how hash tables work in tc filter, and
> what they do? Furthermore, I could use some help with the tc filter police
> things.

Thanks to Andreas Steinmetz and David Sauer, tc hash tables are now
documented as well, thanks!

See:

  http://ds9a.nl/2.4Routing/HOWTO//cvs/2.4routing/output/2.4routing-12.html

And then 'Hashing filters for very fast massive filtering'.

I also finished documenting all parameters for TBF, CBQ, SFQ, PRIO,
bfifo, pfifo and pfifo_fast. All queues in the Linux kernel are now
described in the Linux Advanced Routing & Shaping HOWTO, which can be found on 

                          http://ds9a.nl/2.4Routing

I want to send this off to the LDP and Freshmeat somewhere next week, I
*would really* like people who are knowledgeable about this subject (this
means you, ANK & Jamal 8) ) to read through this. 

This HOWTO is rapidly becoming the perceived authoritative source for
traffic control in linux (google on 'Linux Routing' finds it), it might as
well be right! So if you have any time at all, check the parts you know
about. I expect mistakes.

The parts of the table of contents that document stuff in the kernel not
documented elsewhere:

9. Queueing Disciplines for Bandwidth Management
   9.1 Queues and Queueing Disciplines explained
   9.2 Simple, classless Queueing Disciplines
      9.2.1 pfifo_fast
         9.2.1.1 Parameters & usage
      9.2.2 Token Bucket Filter
         9.2.2.1 Parameters & usage
         9.2.2.2 Sample configuration
      9.2.3 Stochastic Fairness Queueing
         9.2.3.1 Parameters & usage
         9.2.3.2 Sample configuration
   9.3 Advice for when to use which queue
   9.4 Classful Queueing Disciplines
      9.4.1 Flow within classful qdiscs & classes
      9.4.2 The qdisc family: roots, handles, siblings and parents
         9.4.2.1 How filters are used to classify traffic
         9.4.2.2 How packets are dequeued to the hardware
      9.4.3 The PRIO qdisc
         9.4.3.1 PRIO parameters & usage
         9.4.3.2 Sample configuration
      9.4.4 The famous CBQ qdisc
         9.4.4.1 CBQ shaping in detail
         9.4.4.2 CBQ classful behaviour
         9.4.4.3 CBQ parameters that determine link sharing & borrowing
         9.4.4.4 Sample configuration
         9.4.4.5 Other CBQ parameters: split & defmap
      9.4.5 Hierarchical Token Bucket
         9.4.5.1 Sample configuration
   9.5 Classifying packets with filters
      9.5.1 Some simple filtering examples
      9.5.2 All the filtering commands you will normally need

(...)

12. Advanced filters for (re-)classifying packets
    12.1 The "u32" classifier
       12.1.1 U32 selector
       12.1.2 General selectors
       12.1.3 Specific selectors
    12.2 The "route" classifier
    12.3 Policing filters
    12.4 Hashing filters for very fast massive filtering

(...)

14. Advanced & less common queueing disciplines
   14.1 bfifo/pfifo
      14.1.1 Parameters & usage
   14.2 Clark-Shenker-Zhang algorithm (CSZ)
   14.3 DSMARK
      14.3.1 Introduction
      14.3.2 What is Dsmark related to?
      14.3.3 Differentiated Services guidelines
      14.3.4 Working with Dsmark
      14.3.5 How SCH_DSMARK works.
      14.3.6 TC_INDEX Filter
   14.4 Ingress policer qdisc
   14.5 Random Early Drop (RED)
   14.6 VC/ATM emulation
   14.7 Weighted Round Robin (WRR)

The only thing left to document are Policing filters.

Regards,

bert hubert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
Trilab                                 The Technology People
Netherlabs BV / Rent-a-Nerd.nl           - Nerd Available -
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
