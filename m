Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263267AbTDCAQP>; Wed, 2 Apr 2003 19:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263260AbTDCAPi>; Wed, 2 Apr 2003 19:15:38 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:46823 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263231AbTDCAOx>; Wed, 2 Apr 2003 19:14:53 -0500
Date: Wed, 2 Apr 2003 16:28:22 -0800
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@codemonkey.org.uk>, Pavel Machek <pavel@ucw.cz>,
       Jan Dittmer <j.dittmer@portrix.net>, Mark Studebaker <mds@paradyne.com>,
       azarah@gentoo.org, KML <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@brodo.de>, sensors@Stimpy.netroedge.com
Subject: Re: lm sensors sysfs file structure
Message-ID: <20030403002822.GB5130@kroah.com>
References: <1048705473.7569.10.camel@nosferatu.lan> <3E82024A.4000809@portrix.net> <20030326202622.GJ24689@kroah.com> <3E82292E.536D9196@paradyne.com> <20030326225234.GA27436@kroah.com> <3E82D678.9000807@portrix.net> <20030327172516.GA32667@kroah.com> <20030330192312.GB6666@zaurus.ucw.cz> <20030331224439.A7000@kroah.com> <20030401190240.GA6456@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030401190240.GA6456@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 02, 2003 at 12:27:47AM +0100, Dave Jones wrote:
> On Mon, Mar 31, 2003 at 10:44:39PM -0800, Greg KH wrote:
>  > > Well, you had cV for PSU voltages and mV for cpu core voltage. I guess mV
>  > > and mili-deg-C everywhere would be nicer. 
>  > As for why no floating point, it's a pain in the but to both output a
>  > fixed point number from the kernel into floating point, and to parse a
>  > floating point number from userspace within the kernel, turning it into
>  > a fixed point number.  With the proposal I wrote up, none of that is
>  > needed, and all userspace has to do is divide by a factor of 10 to get
>  > the proper value.
> 
> FWIW, I'm taking the same fixed-point millivolt approach with the
> sysfs overrides for cpufreq.  Having similar things in sysfs
> exporting the same units seems to be a good idea.

Hm, in looking around the kernel some more, it seems that there are a
number of other places that export voltage and temperature values (ACPI
being one of the most obvious.)  It might be time to start thinking of a
single userspace library to access all of these kinds of values in a
system, instead of having to probe around different parts of the sysfs
tree by hand...

thanks,

greg k-h
