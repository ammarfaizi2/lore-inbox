Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135546AbRDSEsm>; Thu, 19 Apr 2001 00:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135548AbRDSEsc>; Thu, 19 Apr 2001 00:48:32 -0400
Received: from altus.drgw.net ([209.234.73.40]:44041 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S135546AbRDSEsX>;
	Thu, 19 Apr 2001 00:48:23 -0400
Date: Wed, 18 Apr 2001 23:47:19 -0500
From: Troy Benjegerdes <hozer@drgw.net>
To: Torrey Hoffman <torrey.hoffman@myrio.com>
Cc: linux-kernel@vger.kernel.org,
        "'ionut@moisil.cs.columbia.edu'" <ionut@moisil.cs.columbia.edu>,
        "'steve@navaho.co.uk'" <steve@navaho.co.uk>,
        "'thockin@isunix.it.ilstu.edu'" <thockin@isunix.it.ilstu.edu>,
        "'jgarzik@mandrakesoft.com'" <jgarzik@mandrakesoft.com>,
        "'knghtbrd@debian.org'" <knghtbrd@debian.org>,
        "'becker@scyld.com'" <becker@scyld.com>,
        "'root@frumious.unidec.co.uk'" <root@frumious.unidec.co.uk>,
        "'jocelyn.mayer@netgem.com'" <jocelyn.mayer@netgem.com>
Subject: Re: An improved natsemi driver for 2.2
Message-ID: <20010418234719.B20259@altus.drgw.net>
In-Reply-To: <B65FF72654C9F944A02CF9CC22034CE22E1B89@mail0.myrio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <B65FF72654C9F944A02CF9CC22034CE22E1B89@mail0.myrio.com>; from torrey.hoffman@myrio.com on Wed, Apr 18, 2001 at 01:48:40PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2001 at 01:48:40PM -0700, Torrey Hoffman wrote:
> 
> This version of the natsemi driver is being successfully used by us (Myrio
> Corporation) on hardware that has the 83815 chip on the motherboard, with
> the 2.2.17 kernel.  It appears to work well with both multicast and unicast,
> with decent throughput.  It requires the "pci-scan" module by Donald Becker
> at scyld.com.
> 
> We would be very interested in any feedback on problems with 2.2.17 or
> 2.2.19, and our hope is that some experienced kernel developers will examine
> it and alert us of potential problems we haven't tripped over yet.

Well, on kernel 2.2.19 on a 'regular' PC box (celeron 533), it works
better than the 1.07b version from scyld.com, but it still gets tripped up
pretty bad by nfs traffic. (Have you tried NFS on your board at all?). It
seems to be acting a lot like the 2.4 driver does. (it seems to at least
recover from the error, whereas the scyld.com natsemi.c would appear to
not transmit any packets at all after having trouble).

I'm getting errors in RX packets..

          RX packets:1959 errors:111 dropped:0 overruns:0 frame:305
          TX packets:2275 errors:1 dropped:0 overruns:1 carrier:1

If anyone wants the dmesg output of this problem when running with 
'debug=7', please let me know.

> Most of the code in this driver is by Donald Becker, of course. However, the
> driver from scyld.com could not receive packets on our hardware. We started
> from the modified version posted by Jocelyn Mayer.  That one sort of worked
> for us but had problems. Our version backed out some of those changes, and
> has fixes for CRC calculation, reading the MAC address from the EEPROM, and
> other things. 
> 
> I (Torrey Hoffman) am not the developer of our version, although I did go
> through it and clean it up a little.  I am the alleged "Linux expert" here,
> and if there are problems with the driver I am the person to contact.
> 
> I'm cc'ing everyone on my "natsemi" address list, please trim followups.  
> I do read the mailing list, but please cc me if responding.
> 
> Thanks.
> 
> Torrey Hoffman
> torrey.hoffman@myrio.com
> thoffman@hotmail.com
> 
> 
> 



-- 
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Shulz
