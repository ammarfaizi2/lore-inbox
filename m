Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262937AbSKJCIq>; Sat, 9 Nov 2002 21:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262959AbSKJCIq>; Sat, 9 Nov 2002 21:08:46 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61710 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262937AbSKJCIp>;
	Sat, 9 Nov 2002 21:08:45 -0500
Date: Sun, 10 Nov 2002 02:15:27 +0000
From: Matthew Wilcox <willy@debian.org>
To: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, andmike@us.ibm.com, greg@kroah.com,
       hch@lst.de, linux-kernel@vger.kernel.org, mochel@osdl.org,
       parisc-linux@lists.parisc-linux.org, willy@debian.org
Subject: Re: [parisc-linux] Untested port of parisc_device to generic device interface
Message-ID: <20021110021527.Y12011@parcelfarce.linux.theplanet.co.uk>
References: <adam@yggdrasil.com> <200211100201.gAA21Uv04824@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200211100201.gAA21Uv04824@localhost.localdomain>; from James.Bottomley@steeleye.com on Sat, Nov 09, 2002 at 09:01:29PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 09, 2002 at 09:01:29PM -0500, J.E.J. Bottomley wrote:
> Actually, so would I.  I can suspect why there might exist machines like this 
> (say the consistent attribute is settable at the pgd level)

well, there's a limited amount of space available for consistent mappings
on some machines.  it's basically the same as the vmalloc space.  i think
the best way to handle this is simply to fail to initialise if you can't
get the consistent memory you need.

-- 
Revolutions do not require corporate support.
