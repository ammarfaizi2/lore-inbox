Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbUEOLcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbUEOLcy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 07:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbUEOLcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 07:32:54 -0400
Received: from cantor.suse.de ([195.135.220.2]:27625 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262020AbUEOLcx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 07:32:53 -0400
Date: Sat, 15 May 2004 13:32:51 +0200
From: Olaf Hering <olh@suse.de>
To: Greg KH <greg@kroah.com>, Erik Rigtorp <erkki@linux.nu>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [BK PATCH] USB changes for 2.6.6
Message-ID: <20040515113251.GA27011@suse.de>
References: <20040514224516.GA16814@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040514224516.GA16814@kroah.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Fri, May 14, Greg KH wrote:

>  drivers/usb/misc/cytherm.c           |    9 

current Linus tree does not compile:


  CC [M]  drivers/usb/misc/cytherm.o
drivers/usb/misc/cytherm.c: In function `set_brightness':
drivers/usb/misc/cytherm.c:122: error: `led' undeclared (first use in this function)
drivers/usb/misc/cytherm.c:122: error: (Each undeclared identifier is reported only once
drivers/usb/misc/cytherm.c:122: error: for each function it appears in.)
drivers/usb/misc/cytherm.c: In function `show_temp':
drivers/usb/misc/cytherm.c:161: error: `led' undeclared (first use in this function)
drivers/usb/misc/cytherm.c: In function `show_button':
drivers/usb/misc/cytherm.c:205: error: `led' undeclared (first use in this function)
drivers/usb/misc/cytherm.c: In function `show_port0':
drivers/usb/misc/cytherm.c:242: error: `led' undeclared (first use in this function)
drivers/usb/misc/cytherm.c: In function `set_port0':
drivers/usb/misc/cytherm.c:277: error: `led' undeclared (first use in this function)
drivers/usb/misc/cytherm.c: In function `show_port1':
drivers/usb/misc/cytherm.c:302: error: `led' undeclared (first use in this function)
drivers/usb/misc/cytherm.c: In function `set_port1':
drivers/usb/misc/cytherm.c:337: error: `led' undeclared (first use in this function)
make[3]: *** [drivers/usb/misc/cytherm.o] Error 1

thats the dev_dbg() change.


-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
