Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268472AbTB1W4C>; Fri, 28 Feb 2003 17:56:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268476AbTB1W4C>; Fri, 28 Feb 2003 17:56:02 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:47031 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S268472AbTB1W4A>;
	Fri, 28 Feb 2003 17:56:00 -0500
Message-ID: <3E5FEB28.6020801@us.ibm.com>
Date: Fri, 28 Feb 2003 15:05:12 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Anton Blanchard <anton@samba.org>, Jeff Garzik <jgarzik@pobox.com>,
       Dave Jones <davej@codemonkey.org.uk>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, cliffw@osdl.org, akpm@zip.com.au,
       slpratt@austin.ibm.com, levon@movementarian.org
Subject: Re: [PATCH] documentation for basic guide to profiling
References: <8550000.1046419962@[10.10.2.4]> <20030228002935.256ffa98.akpm@digeo.com> <20030228112238.GJ4911@codemonkey.org.uk> <20030228152838.GB32449@gtf.org> <20010101052723.GB22212@krispykreme> <374420000.1046472228@flay>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
>>>Alpha is supported too... (as least I saw the kernel part go in)
>>
>>sparc64 and ppc64 too, but only timer tick profiling so far.
> 
> I need the magic incantation for oprofile for these then ...
> 
> Actually, better still, we need a wrapper script that works out this
> from /proc/cpuinfo and auto-sets it up for you, if someone who knows
> enough about different Pentium types knows how ... I'm happy to go
> write it if it's easy to detect ...
> 
> My laptop says: 
> 
> model name      : Pentium III (Coppermine)
> 
> but a list of pattern matches from someone (or list of people) who
> know how this works would be very helpful (ie matching up cpuinfo
> to magic incantation to oprofile).

Actually, oprofile already does this somehow.  opcontrol --list-events
will tell you the perf counters for your particular CPU.  When my
scripts are deciding whether the machine is P3/4, they grep through this
list.

I think the proper way to do this is in oprofile itself.  John mentioned
earlier in this thread that they have considered doing default events,
but there may be a better way to do it.
-- 
Dave Hansen
haveblue@us.ibm.com

