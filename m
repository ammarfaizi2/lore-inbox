Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313132AbSDTTST>; Sat, 20 Apr 2002 15:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313163AbSDTTSS>; Sat, 20 Apr 2002 15:18:18 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:35081 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S313132AbSDTTSS>;
	Sat, 20 Apr 2002 15:18:18 -0400
Date: Sat, 20 Apr 2002 11:16:49 -0700
From: Greg KH <greg@kroah.com>
To: Oliver Neukum <oliver@neukum.name>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 usb(?) oops
Message-ID: <20020420181649.GA18542@kroah.com>
In-Reply-To: <200204201533.50375.kiza@gmx.net> <20020420152041.GA17327@kroah.com> <16yyR4-0BqCa8C@fmrl04.sul.t-online.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sat, 23 Mar 2002 16:13:49 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2002 at 07:14:51PM +0200, Oliver Neukum wrote:
> On Saturday 20 April 2002 17:20, Greg KH wrote:
> > On Sat, Apr 20, 2002 at 03:33:50PM +0200, Oliver Feiler wrote:
> > > Hi,
> > >
> > > This oops occurs everytime I use kpilot to hotsync my Handpsring Visor.
> >
> > As per the archives, use this patch to fix this problem:
> > 	http://marc.theaimsgroup.com/?l=linux-kernel&m=101735261202744
> 
> By the way, module usage count handling in the visor driver has
> a race. You increment it after down() which can sleep.

The whole module usage count handling in the usb-serial drivers is
messed up in the 2.4 tree :)

This is hopefully finally fixed in 2.5 right now, and I'll be
backporting these changes to 2.4 after 2.4.19 comes out.

thanks,

greg k-h
