Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319014AbSHSUAR>; Mon, 19 Aug 2002 16:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319015AbSHSUAR>; Mon, 19 Aug 2002 16:00:17 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:2064 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S319014AbSHSUAM>;
	Mon, 19 Aug 2002 16:00:12 -0400
Date: Mon, 19 Aug 2002 12:59:09 -0700
From: Greg KH <greg@kroah.com>
To: Adam Belay <ambx1@netscape.net>
Cc: mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.31 driverfs: patch for your consideration
Message-ID: <20020819195909.GA24488@kroah.com>
References: <Pine.LNX.4.44.0208191111100.1048-100000@cherise.pdx.osdl.net> <3D6113E1.302@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D6113E1.302@netscape.net>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Mon, 22 Jul 2002 18:41:54 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2002 at 03:50:57PM +0000, Adam Belay wrote:
> What does need to be done is a user level program that finds and loads
> the proper modules automatically.  Maybe we could use the existing
> hotplug scripts or we could even start from scratch.  

Um, the current hotplug scripts, and my diethotplug program already do
this.  Why write another user program to do this?  What problem are you
trying to solve?

> Maybe we should make a file in the source tree where driver developers
> can list their supported hardware IDs but more importantly
> documentation on the attributes registered into driverfs.

The support hardware ids are already in the source code, and can be
easily extracted, that is what depmod(8) does to build the modules.*map
files.  See the linux-hotplug documentation at
http://linux-hotplug.sf.net/ and this article:
	http://www.linuxjournal.com/article.php?sid=5604
on how all of this works.  I need to move that article into the
Documentation/DocBook directory someday soon...

driverfs documentation could be retrieved with the DEVICE_ATTR macro, if
we _really_ throught this would be useful.

thanks,

greg k-h
