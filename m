Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261911AbTC0Kmm>; Thu, 27 Mar 2003 05:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261914AbTC0Kml>; Thu, 27 Mar 2003 05:42:41 -0500
Received: from [196.41.29.142] ([196.41.29.142]:47607 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id <S261911AbTC0Kmk>; Thu, 27 Mar 2003 05:42:40 -0500
Subject: Re: lm sensors sysfs file structure
From: Martin Schlemmer <azarah@gentoo.org>
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: Greg KH <greg@kroah.com>, Mark Studebaker <mds@paradyne.com>,
       KML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@brodo.de>,
       sensors@Stimpy.netroedge.com
In-Reply-To: <3E82D678.9000807@portrix.net>
References: <1048582394.4774.7.camel@workshop.saharact.lan>
	 <20030325175603.GG15823@kroah.com> <1048705473.7569.10.camel@nosferatu.lan>
	 <3E82024A.4000809@portrix.net> <20030326202622.GJ24689@kroah.com>
	 <3E82292E.536D9196@paradyne.com> <20030326225234.GA27436@kroah.com>
	 <3E82D678.9000807@portrix.net>
Content-Type: text/plain
Organization: 
Message-Id: <1048762244.4773.1258.camel@workshop.saharact.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2- 
Date: 27 Mar 2003 12:50:44 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-27 at 12:46, Jan Dittmer wrote:
> Greg KH wrote:
> > True, but multi-valued files are not allowed in sysfs.  It's especially
> > obnoxious that you have 3 value files when you read them, but only
> > expect 2 values for writing.  The way I split up the values in the
> > lm75.c driver shows a user exactly which values  are writable, and
> > enforces this on the file system level.
> 
> Agreed, I never knew which of the three values had which functionality.
> For via686a this would be inX, inX_min, inX_max, tempX, tempX_overshoot 
> (over = overshoot = os ?), tempX_hyst, and so on.
> 
> > Entry	Values	Function
> > -----	------	--------
> > temp,
> > temp[1-3]  3	Temperature max, min or hysteresis, and input value.
> > 	       	Floating point values XXX.X or XXX.XX in degrees Celcius.
> 
> If we're restructuring it, I think we should also agree on _one_ common 
> denominator for all values ie. mVolt and milli-Degree Celsius, so that 
> no userspace program ever again has know how to convert them to 
> user-readable values and every user can just cat the values and doesn't 
> have to wonder if it's centi-Volt, milli-Volt, centi-Degree, dezi-Degree 
> or whatever.
> 

Right, can we just get this finalised soon ?  Not much fun in redoing
something 2 times already ;)


Regards,

-- 
Martin Schlemmer


