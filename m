Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264351AbTICTV1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 15:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264231AbTICTTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 15:19:32 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:19399 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S264315AbTICTRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 15:17:02 -0400
Subject: Re: Scaling noise
From: Steven Cole <elenstev@mesatop.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Larry McVoy <lm@work.bitmover.com>, "Brown, Len" <len.brown@intel.com>,
       Giuliano Pochini <pochini@shiny.it>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org, karim@opersys.com
In-Reply-To: <20030903180037.GP4306@holomorphy.com>
References: <BF1FE1855350A0479097B3A0D2A80EE009FCEB@hdsmsx402.hd.intel.com>
	 <20030903111934.GF10257@work.bitmover.com>
	 <20030903180037.GP4306@holomorphy.com>
Content-Type: text/plain
Organization: 
Message-Id: <1062616315.1816.22.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 03 Sep 2003 13:11:55 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-09-03 at 12:00, William Lee Irwin III wrote:

> 
> First, communication requirements originate from the applications, not
> the operating system, hence so long as there are applications with such
> requirements, the requirements for such kernels will exist. Second, the
> proposal is ignoring numerous environmental constraints, for instance,
> the system administration, colocation, and other costs of the massive
> duplication of perfectly shareable resources implied by the clustering.
> Third, the communication penalties are turned from memory access to I/O,
> which is tremendously slower by several orders of magnitude. Fourth, the
> kernel design problem is actually made harder, since no one has ever
> been able to produce a working design for these cache coherent clusters
> yet that I know of, and what descriptions of this proposal I've seen that
> are extant (you wrote some paper on it, IIRC) are too vague to be
> operationally useful.
> 
> So as best as I can tell the proposal consists of using an orders-of-
> magnitude slower communication method to implement an underspecified
> solution to some research problem that to all appearances will be more
> expensive to maintain and keep running than the now extant designs.
> 
You and Larry are either talking past each other, or perhaps it is I who
don't understand the not-yet-existing CC-clusters.  My understanding is
that communication between nodes of a CC-cluster would be through a
shared-memory mechanism, not through much slower I/O such as a network
(even a very fast network).

>From Karim Yaghmour's paper here:
http://www.opersys.com/adeos/practical-smp-clusters/
"That being said, clustering packages may make assumptions that do not
hold in the current architecture. Primarily, by having nodes so close
together, physical network latencies and problems disappear."

> I like distributed systems and clusters, and they're great to use for
> what they're good for. They're not substitutes in any way for tightly
> coupled systems, nor do they render large specimens thereof unnecessary.
> 

My point is this: Currently at least one vendor (SGI) wants to scale the
kernel to 128 CPUs.  As far as I know, the SGI Altix systems can be
configured up to 512 CPUs.  If the Intel Tanglewood really will have 16
cores per chip, very much larger systems will be possible.  Will you be
able to scale the kernel to 2048 CPUs and beyond?  This may happen
during the lifetime of 2.8.x, so planning should be happening either now
or soon.

Steven

