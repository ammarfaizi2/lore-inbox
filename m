Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261205AbSIWMZk>; Mon, 23 Sep 2002 08:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261238AbSIWMZk>; Mon, 23 Sep 2002 08:25:40 -0400
Received: from gate.in-addr.de ([212.8.193.158]:49670 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S261205AbSIWMZj>;
	Mon, 23 Sep 2002 08:25:39 -0400
Date: Mon, 23 Sep 2002 14:31:14 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: "Rhoads, Rob" <rob.rhoads@intel.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Linux Hardened Device Drivers Project
Message-ID: <20020923123114.GC6790@marowsky-bree.de>
References: <D9223EB959A5D511A98F00508B68C20C0A53899F@orsmsx108.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D9223EB959A5D511A98F00508B68C20C0A53899F@orsmsx108.jf.intel.com>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-09-20T17:26:47,
   "Rhoads, Rob" <rob.rhoads@intel.com> said:

Hi Rob,

I fully support the idea to audit the Linux device drivers - using guidelines,
hardware fault injection, stress testing etc - and fixing any potential bugs.
This is obviously a very important task, because the drivers are some of the
most ugly code I've seen in the kernel.

"Pro-active monitoring", ie by basically gathering whatever statistics are
available and feeding them to some sort of user-space application and then
trying to deduce a potential failure is also a very valuable goal; so exposing
more statistics seems definetely good, too. As long as that doesn't introduce
even more errors...

Any help you can offer on the above is surely appreciated by all involved and
will have a direct, positive impact on Linux.

That said, and the fluff in your specification aside (which was very likely
necessary for management ;-), your spec certainly contains some good points on
how to write stable and robust code. (Aside from the comments the others have
raised already regarding event logging and that of course all recommendations
need to be thoughtfully applied to the case in question)

The statistics can best be exposed via driverfs or /proc (for kernels which
don't have driverfs); however, the statistics analyser nor the SNMP agent
pre-processing belong into the kernel itself. Keep the drivers as lean as
possible, that will introduce less errors at this level. I object to the CSM
being in kernel space. Having a more or less common API for the statistics to
be gathered and exposed by the drivers would be highly valuable indeed though.

What are your further timelines?

A lot of the above - ie, audit and test current drivers - can be done without
(at least not with much more) further planning; I'm always rather amazed at
how much effort Intel, IBM and their child OSDL spent on pretty specifications
which could also be applied to real work ;-)



Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Principal Squirrel
Research and Development, SuSE Linux AG
 
``Immortality is an adequate definition of high availability for me.''
	--- Gregory F. Pfister

