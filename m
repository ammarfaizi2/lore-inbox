Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262647AbVCVLz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262647AbVCVLz3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 06:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262654AbVCVLz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 06:55:29 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35720 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262647AbVCVLzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 06:55:23 -0500
Date: Tue, 22 Mar 2005 11:55:22 +0000
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: Dave Jones <davej@redhat.com>, Dan Maas <dmaas@maasdigital.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Distinguish real vs. virtual CPUs?
Message-ID: <20050322115522.GN1450@gallifrey>
References: <20050321202726.A7630@morpheus> <20050322015603.GB19541@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050322015603.GB19541@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.6.11-rc5 (i686)
X-Uptime: 11:54:04 up 4 days, 4 min,  1 user,  load average: 0.00, 0.01, 0.00
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dave Jones (davej@redhat.com) wrote:
> Compare the 'physical id' fields of /proc/cpuinfo, and count
> how many unique values you get.
> Ie, on my dual+ht, I see..
> 
> physical id     : 0
> physical id     : 0
> physical id     : 3
> physical id     : 3
> 
> Which indicates 2 real CPUs split in two.

Is this guarenteed to be safe on all architectures?  Parsing
/proc/cpuinfo accross different architectures can be a bit hairy;
I'm thinking when non-x86 start to have multiple hardware threads
people might want to do the same thing.

Dave
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
