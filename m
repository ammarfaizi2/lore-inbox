Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263363AbTC0SC5>; Thu, 27 Mar 2003 13:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263365AbTC0SC5>; Thu, 27 Mar 2003 13:02:57 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:36872 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263363AbTC0SC4>;
	Thu, 27 Mar 2003 13:02:56 -0500
Date: Thu, 27 Mar 2003 10:13:08 -0800
From: Greg KH <greg@kroah.com>
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: Mark Studebaker <mds@paradyne.com>, azarah@gentoo.org,
       KML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@brodo.de>,
       sensors@Stimpy.netroedge.com
Subject: Re: lm sensors sysfs file structure
Message-ID: <20030327181307.GG32667@kroah.com>
References: <1048582394.4774.7.camel@workshop.saharact.lan> <20030325175603.GG15823@kroah.com> <1048705473.7569.10.camel@nosferatu.lan> <3E82024A.4000809@portrix.net> <20030326202622.GJ24689@kroah.com> <3E82292E.536D9196@paradyne.com> <20030326225234.GA27436@kroah.com> <3E82D678.9000807@portrix.net> <20030327172516.GA32667@kroah.com> <3E833D90.4050104@portrix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E833D90.4050104@portrix.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 27, 2003 at 07:06:08PM +0100, Jan Dittmer wrote:
> Greg KH wrote:
> >>If we're restructuring it, I think we should also agree on _one_ common 
> >>denominator for all values ie. mVolt and milli-Degree Celsius, so that 
> >>no userspace program ever again has know how to convert them to 
> >>user-readable values and every user can just cat the values and doesn't 
> >>have to wonder if it's centi-Volt, milli-Volt, centi-Degree, dezi-Degree 
> >>or whatever.
> >
> >Um, that's what my proposal stated.  Do you not agree with it?  (You're
> >quoting the existing document above, not my proposed changes.)
> 
> I just wanted to emphasis that _all_ units should be milli oder centi. 
> Not mixing centiDegrees and milliVolts or one driver using milliVolt and 
> another centiVolt.

I agree.

> From your description it could well be, that one driver uses centi's 
> and another milli's, both for voltage or one driver uses milliVolt but 
> centi-degree.

Huh?  I said:

temp_max[1-3]   Temperature max value.
                Fixed point value in form XXXXX and should be divided by
                100 to get degrees Celsius.
                Read/Write value.

Where is the ability to use a different scale from different drivers in
that?

Anyway, it sounds like we are agreeing here, so I guess I'll go and
write up the whole document in the new style and post it for comments.

thanks,

greg k-h
