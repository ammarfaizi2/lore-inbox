Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267713AbUIGIiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267713AbUIGIiw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 04:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267721AbUIGIiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 04:38:52 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:32781 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S267713AbUIGIiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 04:38:50 -0400
Message-ID: <413D74A5.3070002@hist.no>
Date: Tue, 07 Sep 2004 10:43:17 +0200
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Keith Whitwell <keith@tungstengraphics.com>,
       Dave Jones <davej@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       Dave Airlie <airlied@linux.ie>, Jon Smirl <jonsmirl@yahoo.com>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mharris@redhat.com
Subject: Re: New proposed DRM interface design
References: <20040904102914.B13149@infradead.org>	 <4139C8A3.6010603@tungstengraphics.com>	 <9e47339104090408362a356799@mail.gmail.com>	 <4139FEB4.3080303@tungstengraphics.com>	 <9e473391040904110354ba2593@mail.gmail.com>	 <1094386050.1081.33.camel@localhost.localdomain>	 <9e47339104090508052850b649@mail.gmail.com>	 <1094393713.1264.7.camel@localhost.localdomain>	 <9e473391040905083326707923@mail.gmail.com>	 <1094395462.1271.12.camel@localhost.localdomain> <9e47339104090509056e54866e@mail.gmail.com>
In-Reply-To: <9e47339104090509056e54866e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:

>They have to be merged. Cards with two heads need the mode set on each
>head. fbdev only sets the mode on one head. If I teach fbdev how to
>set the mode of the other head fbdev needs to learn about memory
>management.  The DRM memory management code is complex and is a big
>chunk of the driver.
>
>I would also like to fix things so that we can have two logged in
>users, one on each head. This isn't going to work if one them uses
>fbdev and keeps swithing the chip to 2D mode while the other user is
>in 3D mode. The chip needs to stay in 3D mode with the CP running.
>
>  
>
Yes!  I use the ruby patch and have two users logged in on the
two heads of a G550.  It works fine - as long as no mode
change is attempted.  And only one user can use 3D (or even 2D),
the other is stuck with a unaccelerated framebuffer.

>We're not going to get OOPS display while running X without merging.
>Something I would really like to have since I just had some and was
>force to hook up a serial console.
>  
>
Also nice to have.

Helge Hafting
