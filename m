Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263113AbTJJQoL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 12:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263109AbTJJQny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 12:43:54 -0400
Received: from wiggis.ethz.ch ([129.132.86.197]:61070 "EHLO wiggis.ethz.ch")
	by vger.kernel.org with ESMTP id S263108AbTJJQnR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 12:43:17 -0400
From: Thom Borton <borton@phys.ethz.ch>
To: Dave Jones <davej@redhat.com>, Russell King <rmk@arm.linux.org.uk>
Subject: Re: PCMCIA CD-ROM does not work
Date: Fri, 10 Oct 2003 18:43:17 +0200
User-Agent: KMail/1.5.4
References: <200310101652.53796.borton@phys.ethz.ch> <200310101744.30827.borton@phys.ethz.ch> <20031010162710.GF25856@redhat.com>
In-Reply-To: <20031010162710.GF25856@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310101843.17341.borton@phys.ethz.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You were both right. With CONFIG_ISA the system does not hang when I 
plug in the PCMCIA card, but I cannot mount it later. 

What can I do then?

Thanks for your help, 

Thom

On Friday 10 October 2003 18:27, you wrote:
> On Fri, Oct 10, 2003 at 05:44:30PM +0200, Thom Borton wrote:
>  > Thanks a lot, I tried the parameters
>  > 	ide1=0x386,0x180 pci=off
>  > and it did not work. pci=off seems to have broken quite a lot
>  > (fb, jogdial, ...). Just leaving it away and just having
>  > ide1=0x386,0x180 didn't help the CD-ROM drive either.
>
> Something else that needs fixing is pcmcia-cs has its exclude list
> for the RadeonIGP bug set way too wide.
> /etc/pcmcia/config.opts has..
>
> exclude port 0x380-0x3ff
>
> Which is bad news, as the Vaio wants port 0x386. The actual ports
> that cause problems are 0x3b0->0x3bb and 0x3d3
>
> After fixing this, it detects the drive, but hangs when you try and
> mount it.
>
> 		Dave

-- 
Thom Borton
Switzerland

