Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265286AbRFUXRD>; Thu, 21 Jun 2001 19:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265287AbRFUXQx>; Thu, 21 Jun 2001 19:16:53 -0400
Received: from amadeus.resilience.com ([209.245.157.29]:28629 "HELO jmcmullan")
	by vger.kernel.org with SMTP id <S265286AbRFUXQq>;
	Thu, 21 Jun 2001 19:16:46 -0400
Date: Thu, 21 Jun 2001 19:01:03 -0400
From: Jason McMullan <jmcmullan@linuxcare.com>
To: linux-kernel@vger.kernel.org
Subject: What are the VM motivations??
Message-ID: <20010621190103.A888@jmcmullan.resilience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<rant>

	I've been reading the VM thread off-and-on for, oh, the last
8 _years_ on linux-kernel. It doesn't seem that much progress gets
made in any one direction. For every throughput optimination for servers,
the desktop people yell 'interactivity'. For every 'long-disk-idle'
desire the laptop guys have, others want large buffer caches.

	It goes back and forth. Everybody pulling from all sides, and
the VM performance has stayed (mostly) in the center.

	Well, I have an idea. Let's take a page from the Neural
Network guys (not the code, just the ideas), and look at VM from a
motivational perspective.

	What if the VM were your little Tuxigachi. A little critter
that lived in your computer, handling all the memory, swap, and
cache management. What would be the positive and negative feedback
you'd give him to tell him how well he's doing VM?

	Here's a short, off-the-cuff list that hopefully most
everyone can agree on.

	Positive
	--------
		* Low system CPU load for the VM timeslice
		* Process IO requests / Disk IO is less than 1.0
		* Large idle times between disk activity
		* Process don't have to wait long for pages from VM.
		* etc.

	Negative
	--------
		* High CPU usage for VM
		* High disk IO for low number of process IO requests.
		* Disk is rarely idle
		* Processes stall for a long time waiting for VM.
		* Deadlocks (fatal!)
		* etc.

	One we know how we would 'train' our little VM critter, we 
will know how to measure its performance. Once we have measures, we
can have good benchmarks. Once we have good benchmarks - we can pick
a good VM alg. 

	Or heck, let's just make the VM a _real_ Neural Network, that
self trains itself to the load you put on the system. Hideously
complex and evil? Well, why not wire up that roach on the floor, eating
that stale cheese doodle. It can't do any worse job on VM that some of the
VM patches I've seen...

</rant>

-- 
Jason McMullan, Senior Linux Consultant
Linuxcare, Inc. 412.432.6457 tel, 412.656.3519 cell
jmcmullan@linuxcare.com, http://www.linuxcare.com/
Linuxcare. Putting open source to work.
