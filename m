Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261960AbVEXTah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbVEXTah (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 15:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbVEXTah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 15:30:37 -0400
Received: from adsl-208-189-133-243.dsl.hstntx.swbell.net ([208.189.133.243]:13809
	"EHLO silversurfer.essinger.com") by vger.kernel.org with ESMTP
	id S261960AbVEXTab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 15:30:31 -0400
From: Karl Essinger <karl@essinger.com>
Organization: Essinger.com
To: linux-kernel@vger.kernel.org
Subject: Re: Linux and Initrd used to access disk : how does it work ?
Date: Tue, 24 May 2005 14:30:06 -0500
User-Agent: KMail/1.7.2
References: <200505241519.j4OFJUR24338@tag.witbe.net>
In-Reply-To: <200505241519.j4OFJUR24338@tag.witbe.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505241430.07066.karl@essinger.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 May 2005 10:19 am, Paul Rolland wrote:

> Ok, basically, the trick is that the BIOS knows how to access the
> disk, and Linux doesn't because it doesnt use the BIOS ? Or is it
> some more subtle (though I doubt) thing in which only a part of the
> disk can be accessed by the BIOS.
>

I'm not an expert in this area, but . . . For lilo I think the boot loader 
just records the physical address where the initrd image resides and loads it 
directly into memory thru the bios. It doesn't need to understand the device 
or filesystem -- it's just retrieving a chunk of data -- as long as the bios 
understands how to read raw (real-mode) data from the device. That would be 
why you have to rerun lilo after changing any boot files -- because the 
addresses probably changed. 

I believe grub understands filesystems but I've also had trouble using grub to 
boot from devices which need module loading, i.e. USB flash drives. I don't 
use grub much though.
