Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312505AbSDEM2W>; Fri, 5 Apr 2002 07:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312513AbSDEM2L>; Fri, 5 Apr 2002 07:28:11 -0500
Received: from pcow057o.blueyonder.co.uk ([195.188.53.94]:43790 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S312505AbSDEM1y>;
	Fri, 5 Apr 2002 07:27:54 -0500
Date: Fri, 5 Apr 2002 13:28:10 +0100
From: Chris Wilson <chris@jakdaw.org>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: P4/i845 Strange clock drifting
Message-Id: <20020405132810.4728c01d.chris@jakdaw.org>
In-Reply-To: <Pine.LNX.4.44.0204031613160.2309-100000@netfinity.realnet.co.sz>
Organization: Hah!
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> > I tried to use 2.5.7-dj2 with Zwane Mwaikambo's thermal LVT support in
> > there but it didn't detect a local APIC on bootup (!) - I'm guessing there
> > needs to be an APIC for Zwane's stuff? When I tried to switch back to
> 
> -dj2 P4 thermal patch is a bit broken (my bad), but the fact that it 
> doesn't detect an APIC means that code would, erm do interesting things...

<grin>

I've now tried a couple more kernels to no avail - nothing can find APICs.
Is it even possible for a P4 to not have a local APIC? System is a
supermicro 5012B*. 

/proc/cpuinfo shows:

flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm

(notice no "apic"). Is this normal/correct? If just just removed the check
from apic.c and tried to enable the apic anyway then are bad things going
to happen? 

I've also noticed [probably unrelated but...] that I can't reboot the box
without use of the reset button - it doesn't come up after /sbin/reboot -f
either. It's at a colo facility so I can't see what's being displayed
until I find out a null modem and go for a drive... :)

Any suggestions?? 

Chris

* http://www.supermicro.com/PRODUCT/SUPERServer/SuperServer5012B-E.htm

-- 
Chris Wilson
chris@jakdaw.org
