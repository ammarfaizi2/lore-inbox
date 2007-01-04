Return-Path: <linux-kernel-owner+w=401wt.eu-S932221AbXADA4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbXADA4l (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 19:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbXADA4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 19:56:41 -0500
Received: from ns2.suse.de ([195.135.220.15]:41003 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932221AbXADA4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 19:56:41 -0500
Date: Wed, 3 Jan 2007 16:56:00 -0800
From: Greg KH <greg@kroah.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: i2c@lm-sensors.org, linux-kernel@vger.kernel.org
Subject: Re: Why to I2c drivers not autoload like other PCI devices?
Message-ID: <20070104005600.GA25712@kroah.com>
References: <20070103165020.4b277ebc@freekitty>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070103165020.4b277ebc@freekitty>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2007 at 04:50:20PM -0800, Stephen Hemminger wrote:
> Is there some missing magic (udev rule?) that keeps i2c device modules
> from loading? For example: the Intel i2c-i801 module ought to get loaded
> automatically on boot up since it has a set of PCI id's that generate
> the necessary module aliases. It would be better if I2C device's autoloaded
> like other PCI devices.

No, it should autoload, if it has a MODULE_DEVICE_TABLE() in it.  In
fact, the i2c-i801 autoloads on one of my machines just fine.  Are you
sure your pci ids match properly?

thanks,

greg k-h
