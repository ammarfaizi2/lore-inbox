Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751784AbWCOWNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbWCOWNZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 17:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751823AbWCOWNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 17:13:24 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:31628
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751811AbWCOWNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 17:13:23 -0500
Date: Wed, 15 Mar 2006 14:13:13 -0800
From: Greg KH <greg@kroah.com>
To: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
Cc: Lanslott Gish <lanslott.gish@gmail.com>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb <linux-usb-devel@lists.sourceforge.net>, tejohnson@yahoo.com,
       hc@mivu.no, vojtech@suse.cz
Subject: Re: [RFC][PATCH] USB touch screen driver, all-in-one
Message-ID: <20060315221313.GB28635@kroah.com>
References: <38c09b90603100124l1aa8cbc6qaf71718e203f3768@mail.gmail.com> <200603112155.38984.daniel.ritz-ml@swissonline.ch> <200603152254.37716.daniel.ritz-ml@swissonline.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603152254.37716.daniel.ritz-ml@swissonline.ch>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2006 at 10:54:37PM +0100, Daniel Ritz wrote:
> hi
> 
> here the updated version of the patch. changes since first version:
> - only advertise ABS_PRESSURE when device supports it
> - handle input_register_device() errors
> - allow vendor specifc init to fail.
> - add invert_x/invert_y modparams
> - only care about 12 bits for panjit
> 
> thanks for all the inputs.
> 
> rgds
> -daniel
> 
> -----
> 
> [PATCH] usb/input/usbtouchscreen: unified USB touchscreen driver
> 
> A new single driver for various USB touchscreen devices. It currently
> supports:
> - eGalax TouchKit
> - PanJit TouchSet
> - 3M/Microtouch
> - ITM Touchscreens
> 
> Support for the diffent devices can be enabled/disable when CONFIG_EMBEDDED
> is set.
> 
> It's offering the same module params for all screens:
> - swap_xy: swaps X and Y axes
> - invert_x/invert_y: inverts X/Y.

These should be sysfs attributes, on the devices, which will allow them
to be set individually for the different devices.  You can use the
module paramater as the default to start with, so don't drop that.

thanks,

greg k-h
