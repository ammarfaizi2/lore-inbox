Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265217AbSIREpg>; Wed, 18 Sep 2002 00:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265262AbSIREpg>; Wed, 18 Sep 2002 00:45:36 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:14598 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265217AbSIREpf>;
	Wed, 18 Sep 2002 00:45:35 -0400
Date: Tue, 17 Sep 2002 21:50:43 -0700
From: Greg KH <greg@kroah.com>
To: Daya Cooppan <dcooppan@attbi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.19 error with usbcore.o
Message-ID: <20020918045042.GB6262@kroah.com>
References: <3D87FFCC.6040003@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D87FFCC.6040003@attbi.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2002 at 11:23:40PM -0500, Daya Cooppan wrote:
> Hi
> 
> The default for the USB section is to included USB support (y) in the 
> kernel. I am assuming the usbcore.o got incorporated into the kernel 
> build tree during [make dep; make bzImage; make modules; make 
> modules_install]. I continued to get mousedev errors ...verified that I 
> had mouse support, hid support, uhci support, all this look good. As 
> soon as I changed "USB Support" from (y) to (m), i.e. made usbcore.o a 
> loadable module WALLA! usb devices started to work. Question: Is there a 
> bug with (y) support for "USB Support" ?

No, you need to set CONFIG_INPUT to y if you are also selecting the HID
driver to be compiled into the kernel.  That should solve your problem.

thanks,

greg k-h
