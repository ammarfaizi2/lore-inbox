Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261177AbTC0SmM>; Thu, 27 Mar 2003 13:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261273AbTC0SmM>; Thu, 27 Mar 2003 13:42:12 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:44296 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261177AbTC0SmL>;
	Thu, 27 Mar 2003 13:42:11 -0500
Date: Thu, 27 Mar 2003 10:52:22 -0800
From: Greg KH <greg@kroah.com>
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: Mark Studebaker <mds@paradyne.com>, azarah@gentoo.org,
       KML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@brodo.de>,
       sensors@Stimpy.netroedge.com
Subject: Re: lm sensors sysfs file structure
Message-ID: <20030327185222.GI32667@kroah.com>
References: <1048582394.4774.7.camel@workshop.saharact.lan> <20030325175603.GG15823@kroah.com> <1048705473.7569.10.camel@nosferatu.lan> <3E82024A.4000809@portrix.net> <20030326202622.GJ24689@kroah.com> <3E82292E.536D9196@paradyne.com> <20030326225234.GA27436@kroah.com> <3E83459A.3090803@portrix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E83459A.3090803@portrix.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 27, 2003 at 07:40:26PM +0100, Jan Dittmer wrote:
> Greg KH wrote:
> >That would give us one value per file, use no floating point in the
> >kernel (fake or not) and generally make things a whole lot more orderly.
> >Also, if a sensor does not have a max value (for example, I don't really
> >know if this is true), instead of having to fake a value, it can just
> >not create the file.  Then userspace can easily detect this is not
> >supported, and is not a placeholder value.
> >
> 
> Is this the way you want to go? Just an example for the voltages.

That looks very good to me, nice job.

Sensors developers, does this look sane?

> Btw, is it indended behaviour of sysfs, that after writing to a file, 
> the size is zero?

Hm, don't know about that, I haven't seen that before.  If you cat the
file after writing it, does the file size change?

thanks,

greg k-h
