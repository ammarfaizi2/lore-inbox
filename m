Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264931AbTBEVqh>; Wed, 5 Feb 2003 16:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264943AbTBEVqh>; Wed, 5 Feb 2003 16:46:37 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:28474 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S264931AbTBEVqg>; Wed, 5 Feb 2003 16:46:36 -0500
To: Dave Jones <davej@codemonkey.org.uk>
Cc: b_adlakha@softhome.net, linux-kernel@vger.kernel.org
Subject: Re: HYPERTHREADING on older P4???
References: <courier.3E410B73.000041C3@softhome.net>
	<20030205130707.GA616@codemonkey.org.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 05 Feb 2003 14:55:55 -0700
In-Reply-To: <20030205130707.GA616@codemonkey.org.uk>
Message-ID: <m1n0laz91w.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@codemonkey.org.uk> writes:

> On Wed, Feb 05, 2003 at 06:02:43AM -0700, b_adlakha@softhome.net wrote:
>  > hi,
>  > /proc/cpuinfo reports "ht" in the supported options...I have a p4 2 ghz 
>  > stepping 4, and when I boot with an SMP kernel, it shows another thing :
>  > siblings 1 
>  > 
>  > I think HT is there in all p4s, so can it be enabled in older P4s? Like 
>  > mine? What does "siblings = 1" mean? 
>  
> It means there is one 'thread'. Ergo, you do not have the possibility
> of running this as you would a true HT P4.  There are a limited number
> of Northwood P4's out there which do support HT and have >1 sibling,
> but asides from those, you'll need a Xeon to take advantage of it.
> 
> There are countless rumours of being able to enable extra siblings
> by poking MSRs, but not one person has to my knowledge achieved this.
> Some folks have also allegedly found that snipping pins or wiring extra
> bits to them have enabled the 'extra sibling'. Whether this is true or
> not, and whether it is 100% equivalent to a real HT part is again,
> questionable.

I have had some limited experience with an older HT capable Xeon,
that reported 1 sibling.  Essentially the result was that sending a
wakeup ipi to the next sibling was a good way to lockup the machine.
I was actually looking for the apic id of the other Xeon in the box
and was sending to the sibling by accident.

>From what I can tell from various micro-benchmarks and other strange
experiences intel has had to work fairly hard to get additional
sibling CPUs to perform correctly and well.  And the development
versions that are present but disabled in older dies are not likely
to be useful.

Eric
