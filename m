Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265513AbSKLAvS>; Mon, 11 Nov 2002 19:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265736AbSKLAvS>; Mon, 11 Nov 2002 19:51:18 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:19726 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265513AbSKLAvR>;
	Mon, 11 Nov 2002 19:51:17 -0500
Date: Mon, 11 Nov 2002 16:53:02 -0800
From: Greg KH <greg@kroah.com>
To: "Lee, Jung-Ik" <jung-ik.lee@intel.com>
Cc: pcihpd-discuss@lists.sourceforge.net,
       linux ia64 kernel list <linux-ia64@linuxia64.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.45 cpqphp driver patch w/ intcphp driver enhancements
Message-ID: <20021112005302.GD26926@kroah.com>
References: <72B3FD82E303D611BD0100508BB29735046DFF89@orsmsx102.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72B3FD82E303D611BD0100508BB29735046DFF89@orsmsx102.jf.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2002 at 04:20:16PM -0800, Lee, Jung-Ik wrote:
> Hi Greg,
> 
> Here's PCI hotplug driver patch to cpqphp driver in 2.5.45.

Thanks for the patch.  I'm a bit busy today, but should be able to test
this out later tomorrow if all goes well, sorry in advance for the
delay.

That being said, I have a minor nit:

-config HOTPLUG_PCI_COMPAQ
-       tristate "Compaq PCI Hotplug driver"
-       depends on HOTPLUG_PCI && X86
+config HOTPLUG_PCI_COMPAQ_INTEL
+       tristate "Compaq/Intel PCI Hotplug driver"
+       depends on HOTPLUG_PCI

The device is _still_ a Compaq device, Intel just licensed it from them.
Changing the name to an Intel device does Compaq a disservice, and in
the past, when I accidentally did this, they complained loudly.

So I'd stick to the Compaq name only :)

I'll get back to you with actual technical comments on the patch
hopefully by tomorrow evening.

thanks,

greg k-h
