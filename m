Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316023AbSFJUJ3>; Mon, 10 Jun 2002 16:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316039AbSFJUJ2>; Mon, 10 Jun 2002 16:09:28 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:52487 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316023AbSFJUJ1>;
	Mon, 10 Jun 2002 16:09:27 -0400
Date: Mon, 10 Jun 2002 13:05:43 -0700
From: Greg KH <greg@kroah.com>
To: John Levon <movement@marcelothewonderpenguin.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: External compilation
Message-ID: <20020610200542.GB3508@kroah.com>
In-Reply-To: <20020609142602.GA77496@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Mon, 13 May 2002 18:01:41 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 09, 2002 at 03:26:02PM +0100, John Levon wrote:
> 
> On a related note, is it at all possible to make a "mini filesystem"
> that will work on 2.2 upwards, so I can avoid proc,sysctl, and ioctl ?

Take a look at drivers/usb/inode.c in the 2.2 kernel.  Yes it's ugly,
but seems to be the only way to do it on 2.2.  It also will work on 2.4
and 2.5.  For 2.4/2.5 it's _much_ easier to make a "mini filesystem".
See libfs on 2.5, or the pci_hotplug code in 2.4 for examples of this.

Hope this helps,

greg k-h
