Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291446AbSBAALh>; Thu, 31 Jan 2002 19:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291447AbSBAALc>; Thu, 31 Jan 2002 19:11:32 -0500
Received: from rakis.net ([207.8.143.12]:64651 "EHLO egg.rakis.net")
	by vger.kernel.org with ESMTP id <S291446AbSBAALO> convert rfc822-to-8bit;
	Thu, 31 Jan 2002 19:11:14 -0500
Date: Thu, 31 Jan 2002 19:11:14 -0500 (EST)
From: Greg Boyce <gboyce@rakis.net>
X-X-Sender: gboyce@egg
To: Roger Larsson <roger.larsson@norran.net>
Cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Machines misreporting Bogomips
In-Reply-To: <200201312333.g0VNXnZ11421@maile.telia.com>
Message-ID: <Pine.LNX.4.42.0201311910170.25129-100000@egg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The machine reporting cache size of 0KB is the one that's behaving
normally.  The misbehaving machine is the one reporting 512K cache.

> > > cache size        : 512 KB
...
> > > bogomips  : 4.06

On Fri, 1 Feb 2002, Roger Larsson wrote:

> On Fridayen den 1 February 2002 00.21, Matthew Dharm wrote:
> > I don't know if this will help much, but I have seen that type of
> > performance drop on systems when the entire cache is disabled.
> >
> > Matt
>
> >From the report below...
> > > cache size	: 0 KB
>
> /RogerL
>
> >
> > On Thu, Jan 31, 2002 at 05:55:57PM -0500, Greg Boyce wrote:
> > > kernel folk,
> > >
> > > I've got a strange issue that I've been struggling to find the solution
> > > to for some time now.
> > >
> > > I work in a group that assists in the managing of large numbers of
> > > deployed linux boxes running variants of the 2.2 kernel on them.  The
> > > machines themselves are all pretty standard.  There are slight variances
> > > on vendors, cpu speeds, etc., but they're all running from the same
> > > motherboards.
> > >
> > > Every once in a while we come across single machines which are running a
> > > lot slower than they should be, and are misreporting their speed in
> > > bogomips under /proc/cpuinfo.  Reinstalling the OS and changing versions
> > > of the kernel don't appear to affect the machines themselves at all.
> > >
> > > I was wondering if anyone would be able to provide me with a starting
> > > point to hunt this down.  The only solution we had found in the past was
> > > to replace the machines, but some of them are located out of the country
> > > and that would be expensive.
> > >
> > > Here is the output from /proc/cpuinfo for machines.  The first machine is
> > > normal, the second is affected by this bug.  They're both running the
> > > same hardware, although the first machine's CPU is 650mhz instead of
> > > 500mhz.
> > >
> > > Machine 1:
> > > processor	: 0
> > > vendor_id	: GenuineIntel
> > > cpu family	: 6
> > > model		: 8
> > > model name	: Pentium III (Coppermine)
> > > stepping	: 3
> > > cpu MHz		: 645.676332
> > > cache size	: 0 KB
> > > fdiv_bug	: no
> > > hlt_bug		: no
> > > sep_bug		: no
> > > f00f_bug	: no
> > > coma_bug	: no
> > > fpu		: yes
> > > fpu_exception	: yes
> > > cpuid level	: 3
> > > wp		: yes
> > > flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> > > cmov pat pse36 psn mmx osfxsr kni
> > > bogomips	: 643.89
> > >
> > > Machine 2:
> > > processor	: 0
> > > vendor_id	: GenuineIntel
> > > cpu family	: 6
> > > model		: 7
> > > model name	: Pentium III (Katmai)
> > > stepping	: 3
> > > cpu MHz		: 496.677416
> > > cache size	: 512 KB
> > > fdiv_bug	: no
> > > hlt_bug		: no
> > > sep_bug		: no
> > > f00f_bug	: no
> > > coma_bug	: no
> > > fpu		: yes
> > > fpu_exception	: yes
> > > cpuid level	: 2
> > > wp		: yes
> > > flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> > > cmov pat pse36 mmx osfxsr kni
> > > bogomips	: 4.06
> > >
> > > Let me know if there's anything else I can provide to help with the
> > > diagnosis.  The machine itself is an IBM Netfinity 4000R.
> > >
> > > --
> > > Gregory Boyce
> > >
> > >
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > > in the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
>
> --
> Roger Larsson
> Skellefteå
> Sweden
>

