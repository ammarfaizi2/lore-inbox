Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287676AbSBRR4m>; Mon, 18 Feb 2002 12:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290956AbSBRRyM>; Mon, 18 Feb 2002 12:54:12 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:19206 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S290926AbSBRRjY>;
	Mon, 18 Feb 2002 12:39:24 -0500
Date: Mon, 18 Feb 2002 09:34:33 -0800
From: Greg KH <greg@kroah.com>
To: Miles Lane <miles@megapathdsl.net>
Cc: Jaroslav Kysela <perex@suse.cz>, linux-kernel@vger.kernel.org,
        Abramo Bagnara <abramo@alsa-project.org>
Subject: Re: How do I get the ALSA code in 2.5.5-pre1 working?
Message-ID: <20020218173433.GA19959@kroah.com>
In-Reply-To: <3C6ED744.9010504@megapathdsl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C6ED744.9010504@megapathdsl.net>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 21 Jan 2002 15:29:19 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2002 at 02:03:48PM -0800, Miles Lane wrote:
> Hello,
> 
> I have the linux hotplug scripts installed.  When I built
> the drivers as modules, they did not autoload, as they should
> have.  Are you working to make the drivers register themselves
> during the boot process so that they are autoloaded without
> having to hack the modules.conf file?

It looks like tha ALSA pci drivers properly do the MODULE_DEVICE_TABLE
stuff, and I have the proper entries in my modules.pcimap for my sound
cards.

What driver are you using that you do not see this working for?

And pci drivers do not get automatically loaded by the hotplug
subsystem, unless you insert the card _after_ userspace is up and
running (like for a PCMCIA or pci hotplug system.)

thanks,

greg k-h
