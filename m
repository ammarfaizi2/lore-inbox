Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266101AbTIKFVT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 01:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266102AbTIKFVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 01:21:19 -0400
Received: from storm.he.net ([64.71.150.66]:55707 "HELO storm.he.net")
	by vger.kernel.org with SMTP id S266101AbTIKFVS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 01:21:18 -0400
Date: Wed, 10 Sep 2003 21:46:50 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test5 usbserial oops
Message-ID: <20030911044650.GA10064@kroah.com>
References: <20030911033054.GA1375@glitch.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030911033054.GA1375@glitch.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 10:30:55PM -0500, Greg Norris wrote:
> I'm seeing a consistent oops with usbserial under 2.6.0-test5, which
> occurs when I try to sync my pda using pilot-link.  The module seems to
> load (via hotplug) without any difficulty, and the sync itself works
> fine... the oops occurs when the module is unloaded.  Once this
> happens, it requires a reboot to get usb working again.
> 
> I've attached the decoded oops, along with my kernel .config.  If I
> need to provide any additional information, please let me know.

Can you load both the usbserial and visor modules with "debug=1":
	modprobe usbserial debug=1
	modprobe visor debug=1

and then sync and remove the visor driver?
I'd be very interested in the kernel debug log right up to the kernel
oops.

thanks,

greg k-h
