Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261413AbSJZStR>; Sat, 26 Oct 2002 14:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261427AbSJZStR>; Sat, 26 Oct 2002 14:49:17 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:36102 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261413AbSJZStQ>;
	Sat, 26 Oct 2002 14:49:16 -0400
Date: Sat, 26 Oct 2002 11:53:33 -0700
From: Greg KH <greg@kroah.com>
To: Kevin Brosius <cobra@compuserve.com>
Cc: Oliver Neukum <oliver@neukum.name>, kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.44-ac3 usb audio - illegal sleep call
Message-ID: <20021026185333.GA2876@kroah.com>
References: <3DBAA320.B02AB7FC@compuserve.com> <200210261902.32626.oliver@neukum.name> <3DBADB56.C782BD1D@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DBADB56.C782BD1D@compuserve.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 26, 2002 at 02:13:42PM -0400, Kevin Brosius wrote:
> Oliver Neukum wrote:
> > 
> > 
> > Am Samstag, 26. Oktober 2002 16:13 schrieb Kevin Brosius:
> > > I've been trying to get USB up to test a audio device and just managed
> > > to get it all working to some extent.  When using xmms to play audio
> > > (usb audio module - oss soundcore) I see the following kernel messages
> > > repeatedly, maybe once a second or so:
> > 
> > Go edit usbout_completed() and usbin_completed(). Change the GFP_KERNEL
> > in usb_submit_urb to GFP_ATOMIC.
> > Does that help ?
> > 
> >         Regards
> >                 Oliver
> 
> 
> Hi guys,
>   No... Well, actually, it does change which function gives the
> warning.  Now usbout_sync_completed is complaining.

Heh, can you change that instance of GFP_KERNEL to GFP_ATOMIC too?

thanks,

greg k-h
