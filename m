Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131233AbRAED5P>; Thu, 4 Jan 2001 22:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131372AbRAED5F>; Thu, 4 Jan 2001 22:57:05 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:27182 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S131233AbRAED45>;
	Thu, 4 Jan 2001 22:56:57 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
cc: linux-usb-devel@lists.sourceforge.net
Subject: Re: Announce: modutils 2.4.0 is available 
In-Reply-To: Your message of "Fri, 05 Jan 2001 13:59:12 +1100."
             <14993.978663552@kao2.melbourne.sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 05 Jan 2001 14:56:29 +1100
Message-ID: <16062.978666989@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 Jan 2001 13:59:12 +1100, 
Keith Owens <kaos@ocs.com.au> wrote:
>modutils-2.4.0.tar.gz           Source tarball, includes RPM spec file

I have just found out that there was an incompatible change to struct
usb_device_id during 2.4.0-prerelease :(((.  That means that all
versions of depmod will break on kernel 2.4.0 if you have any modules
that use MODULE_DEVICE_TABLE(usb).  Incompatible changes to an ABI
structure without notification immediately prior to a major kernel
release, yech!

If you have usb modules then stay on kernel 2.4.0-prerelease or compile
usb without modules or wait until I can test and release modutils
2.4.1.  The usb hotplug utilities will also have to change to handle
the new table layout.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
