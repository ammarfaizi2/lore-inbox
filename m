Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264939AbTAJLK0>; Fri, 10 Jan 2003 06:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264943AbTAJLK0>; Fri, 10 Jan 2003 06:10:26 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:21242 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S264939AbTAJLKZ>;
	Fri, 10 Jan 2003 06:10:25 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15902.44075.649993.9488@harpo.it.uu.se>
Date: Fri, 10 Jan 2003 12:19:07 +0100
To: Dave Jones <davej@codemonkey.org.uk>
Cc: jamesclv@us.ibm.com, Jason Lunz <lunz@falooley.org>,
       linux-kernel@vger.kernel.org
Subject: Re: detecting hyperthreading in linux 2.4.19
In-Reply-To: <20030110110547.GC29190@codemonkey.org.uk>
References: <slrnb1rlct.g2c.lunz@stoli.localnet>
	<200301091337.04957.jamesclv@us.ibm.com>
	<15902.28835.127030.199073@harpo.it.uu.se>
	<20030110110547.GC29190@codemonkey.org.uk>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones writes:
 > On Fri, Jan 10, 2003 at 08:05:07AM +0100, Mikael Pettersson wrote:
 > 
 >  > If the kernel has sched_setaffinity() or some other way of binding a process
 >  > to a given CPU (as numbered by the kernel, which may or may not be related
 >  > to any physical CPU numbers), then this will do it: execute CPUID on each
 >  > CPU and check the initial APIC ID field. If you find one that's non-zero,
 >  > then HT is enabled.
 > 
 > That's a horrible way of reimplementing /dev/cpu/x/cpuid  8-)

True. I forgot about that interface since I personally never configure or use it.

So this answers the original question. Just access /dev/cpu/$CPU/cpuid
for all (accessible) values of $CPU.
