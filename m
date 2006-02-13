Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbWBMQtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbWBMQtT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 11:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbWBMQtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 11:49:19 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:14866 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S932157AbWBMQtS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 11:49:18 -0500
Date: Mon, 13 Feb 2006 17:49:11 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060213164911.GB75835@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <20060125181847.b8ca4ceb.grundig@teleline.es> <20060125173127.GR4212@suse.de> <43D7C1DF.1070606@gmx.de> <878xt3rfjc.fsf@amaterasu.srvr.nix> <43ED005F.5060804@tmr.com> <20060210235654.GA22512@kroah.com> <20060212120450.GA93069@dspnet.fr.eu.org> <20060212164633.GA2941@kroah.com> <20060212211406.GA48606@dspnet.fr.eu.org> <20060213062412.GB2335@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060213062412.GB2335@kroah.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2006 at 10:24:12PM -0800, Greg KH wrote:
> On Sun, Feb 12, 2006 at 10:14:06PM +0100, Olivier Galibert wrote:
> > On Sun, Feb 12, 2006 at 08:46:33AM -0800, Greg KH wrote:
> > > On Sun, Feb 12, 2006 at 01:04:51PM +0100, Olivier Galibert wrote:
> > > > You need to call udevinfo for that, or parse /dev/.udev/*.  Do you
> > > > think it would be possible to have hotplug/udev/whatever exists in the
> > > > future to give that information back in the kernel and have it appear
> > > > in sysfs?
> > > 
> > > No.  Why would it when it is very simple to query udevinfo for that?
> > 
> > In order not to depend on a userland package for the kernel service of
> > device enumeration?  It's udevinfo now, what will it be in two years?
> 
> WTF?  You are depending on that same program to create your device
> nodes.  If you don't want to use that program to do it, then use
> something else, or use a static device tree, which works like always.

Funnily enough, my, say, mp3 usb key sync system would like to run as
non-root and does not want to know or care about what program creates
the device nodes.  Too bad this otherwise beautiful and useful sysfs
is crippled by design.


> sysfs exports everything that userspace needs to know, if it wants to
> create a device node to talk to that specific device.  udev used it to
> create your /dev tree, while other programs use it to create temporary
> device nodes to do other things to your devices.  Either way, the kernel
> doesn't know, or care what you call those device nodes.

You mean root is mandatory to talk with devices, whatever they are?

  OG.
