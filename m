Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132596AbRC1XPh>; Wed, 28 Mar 2001 18:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132609AbRC1XPa>; Wed, 28 Mar 2001 18:15:30 -0500
Received: from hypnos.cps.intel.com ([192.198.165.17]:51198 "EHLO
	hypnos.cps.intel.com") by vger.kernel.org with ESMTP
	id <S132596AbRC1XPM>; Wed, 28 Mar 2001 18:15:12 -0500
Message-ID: <4148FEAAD879D311AC5700A0C969E8905DE7D2@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Pavel Machek'" <pavel@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: sfr@canb.auug.org.au, twoller@crystal.cirrus.com,
   linux-kernel@vger.kernel.org
Subject: RE: Incorrect mdelay() results on Power Managed Machines x86
Date: Wed, 28 Mar 2001 15:12:01 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sounds like the TSC makes a lousy calibration method ;-)

I know on ACPI systems you are guaranteed a PM timer running at ~3.57 Mhz.
Could udelay use that, or are there other timers that are better (maybe
without the ACPI dependency)? 

Regards -- Andy

> -----Original Message-----
> From: Pavel Machek [mailto:pavel@suse.cz]
> Sent: Sunday, March 25, 2001 4:07 PM
> To: Alan Cox
> Cc: sfr@canb.auug.org.au; twoller@crystal.cirrus.com;
> linux-kernel@vger.kernel.org
> Subject: Re: Incorrect mdelay() results on Power Managed Machines x86
> 
> 
> Hi!
> 
> > > On the ThinkPad 600E (at least), we get a Power Status 
> Change APM event.
> > 
> > Any reason we couldn't recalibrate the bogomips on a power 
> status change,
> > at least for laptops we know appear to need it (I can make 
> the DMI code look
> > for matches there..)
> 
> Notice that this is not 100% solution. APM is async, and you 
> might already
> did few wrong delays by the time apm event is delivered to you.
> 
> Also notice that at least my toshiba goes low speed (150MHz) on
> *) batteries going low
> *) overheat
> 
> It goes back to 300MHz at ac power. Another crazy thing: it 
> goes down to
> 35MHz on extreme overheat -- that's factor of 10 change.
> -- 
> Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
> details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

