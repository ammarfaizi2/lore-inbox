Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262869AbVAKRDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262869AbVAKRDX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 12:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262839AbVAKQ4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 11:56:49 -0500
Received: from web54502.mail.yahoo.com ([68.142.225.172]:14711 "HELO
	web54502.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262832AbVAKQpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 11:45:16 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=fMIwqJEQVAKXuoY0rYAXucjbFGyMFhxi8jTquQWEiUPtc5MS7+qz7XdZ62nwCFdw+Boq+FaSrBOIOm2KOCNH0c4oSnFxpRgJ2aDqjW58yU66kTAwek6g9Ft9NE/KpD4844h5TOWAMD16bry69KjCSm4h/ppwSC33pbV5ci9O76U=  ;
Message-ID: <20050111164507.92884.qmail@web54502.mail.yahoo.com>
Date: Tue, 11 Jan 2005 08:45:07 -0800 (PST)
From: Shakthi Kannan <shakstux@yahoo.com>
Subject: Re: mount PCI-express RAM memory as block device
To: linux-kernel@vger.kernel.org
In-Reply-To: <20050107201730.40634.qmail@web54502.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

--- "Arnd Bergmann" <arnd@arndb.de> wrote:
> You could use the MTD block driver with on the phram

> device by simply specifying the address/size of the 
> memory as a module parameter.  If you need 
> autodetection, the easiest way to do that would be 
> including the phram MTD driver in your pci device 
> driver.

I studied the slram.c and rd.c device drivers. The
ramdisk driver that I had written earlier, similar to
the above, had worked fine. With respect to PCI
express, I had to modify just the memory tranfer
function. The memcpy functions translate to byte
access. But, PCI express is dword access. So, I wrote
my own memory copy to do long read/write using
readl(), writel(). The block device driver works fine.

Thanks,

K Shakthi

=====
-----------------------------------------------------
K Shakthi
Specsoft (Hexaware Technologies), ASIC Design Center
http://www.geocities.com/shakthimaan
-----------------------------------------------------


		
__________________________________ 
Do you Yahoo!? 
Read only the mail you want - Yahoo! Mail SpamGuard. 
http://promotions.yahoo.com/new_mail 
