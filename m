Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313571AbSGDUBp>; Thu, 4 Jul 2002 16:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313628AbSGDUBo>; Thu, 4 Jul 2002 16:01:44 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:24583 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S313571AbSGDUBn>;
	Thu, 4 Jul 2002 16:01:43 -0400
Date: Thu, 4 Jul 2002 13:02:37 -0700
From: Greg KH <greg@kroah.com>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Manfred Spraul <manfred@colorfullife.com>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: usb storage cleanup
Message-ID: <20020704200237.GB32526@kroah.com>
References: <3D236950.5020307@colorfullife.com> <20020703144329.D8033@one-eyed-alien.net> <3D237870.7010600@colorfullife.com> <20020703170521.E8033@one-eyed-alien.net> <3D248208.4060500@colorfullife.com> <20020704125012.C17360@one-eyed-alien.net> <20020704195432.GD7534@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020704195432.GD7534@conectiva.com.br>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Thu, 06 Jun 2002 18:51:09 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2002 at 04:54:32PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jul 04, 2002 at 12:50:12PM -0700, Matthew Dharm escreveu:
> > > > Because relying on a pointer has caused problems in the past, especially
> > > > when there are concerns that the pointer might be invalid.
> 
> > > Could you explain a bit more? How could the pointer become invalid?
>  
> > There was a large discussion of this in relation to another driver on
> > linux-usb-devel... basically, the pointer is just an address to a structure
> > owned by an HCD... it's entirely possible for the structure to go away on
> > us unexpectedly.  We _should_ get the notification via the _disconnect()
> > call, but real-world experience showed us that this wasn't always
> > happening.
> 
> Humm, I believed that USB was using refcounting

Parts of it is, parts aren't :(

Soon, due to the struct device and struct driver conversion everything
should be properly reference counted.  But I'm not really aware of the
problem that Matt is referring to.  Matt, what structure is
disappearing?

thanks,

greg k-h
