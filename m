Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273994AbRI3TMQ>; Sun, 30 Sep 2001 15:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273992AbRI3TMG>; Sun, 30 Sep 2001 15:12:06 -0400
Received: from brick.homesquared.com ([216.177.65.65]:4807 "EHLO
	brick.homesquared.com") by vger.kernel.org with ESMTP
	id <S273990AbRI3TL7>; Sun, 30 Sep 2001 15:11:59 -0400
Message-ID: <3BB76E9A.4C6ECA30@homesquared.com>
Date: Sun, 30 Sep 2001 12:12:26 -0700
From: Jeremy Jackson <jjackson@homesquared.com>
Organization: HomeSquared Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: John Gluck <jgluckca@home.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10 and ipchains support.
In-Reply-To: <3BB769F3.A9273786@home.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Gluck wrote:
> 
> Hi All
> 
> I have been trying to get ipchains support in the 2.4.10 kernel.
> I do a make xconfig and it's greyed out.
> Has ipchains support been dropped and is this just an artifact??

Definitely not.  RedHat 7.1 default install uses 2.4.2 kernel with
ipchains.  You can also say "service ipchains stop; rmmod ipchains; 
service iptables start" and switch without rebooting;  The KEY is
to remove all ipchains modules before loading the iptables ones.
It works, I do this on a regular basis.

> 
> Iptables support works but some of the modules have undefineds when they
> are loaded.
> This symbol problem for iptables seems to come and go in 2.4.x kernels.
> I complie support into the kernel and everything else as modules.

If the above does not solve your problem, make sure you are configuring
the kernel properly.  One easy way to do this is to take a working
config - the kernel-source-2.4.XXX.i386.rpm from redhat 7.1 contains
an extra directory /config with the actual .config files used to compile
redhat kernels (BTW anyone know why I can't do rpm --rebuild with the
kernels in RH7.1?)  You should use these as an example. (or some
other documentation) Once again, this DOES work (anyone- is there
some issue specifically with 2.4.10?)
