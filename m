Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135297AbRARMn3>; Thu, 18 Jan 2001 07:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135307AbRARMnT>; Thu, 18 Jan 2001 07:43:19 -0500
Received: from the.earth.li ([195.149.39.90]:33284 "EHLO the.earth.li")
	by vger.kernel.org with ESMTP id <S135297AbRARMnE>;
	Thu, 18 Jan 2001 07:43:04 -0500
Date: Thu, 18 Jan 2001 13:42:50 +0100
From: Simon Huggins <huggie@earth.li>
To: Andrey Savochkin <saw@saw.sw.com.sg>
Cc: eepro100@scyld.com, linux-kernel@vger.kernel.org
Subject: Re: eepro cmd_wait
Message-ID: <20010118134250.C19784@the.earth.li>
Mail-Followup-To: Andrey Savochkin <saw@saw.sw.com.sg>, eepro100@scyld.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010118131011.B19784@the.earth.li> <20010118201731.A8492@saw.sw.com.sg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010118201731.A8492@saw.sw.com.sg>; from saw@saw.sw.com.sg on Thu, Jan 18, 2001 at 08:17:31PM +0800
Organization: Black Cat Networks, http://www.blackcatnetworks.co.uk/
X-Attribution: huggie
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiya Andrey,

On Thu, Jan 18, 2001 at 08:17:31PM +0800, Andrey Savochkin wrote:
> On Thu, Jan 18, 2001 at 01:10:11PM +0100, Simon Huggins wrote:
> > We have a server running 2.2.18 + RAID which has an eepro100 in it.
> > It's connected to a Dlink DFE 816 100 16port 100baseTX hub.
> > When the machine boots we get a whole series of timeout errors.
> > Jan 18 11:58:09 miguet kernel: eepro100: cmd_wait for(0x70) timedout with(0x70)!
> Could you try to add
> 	inl(ioaddr + SCBPointer);
> 	udelay(10);
> before
> 	outb(RxAddrLoad, ioaddr + SCBCmd);
> in speedo_resume()?

> These two line are a workaround for the RxAddrLoad timing bug,
> developed by Donald Becker.  wait_for_cmd_done timeouts may be related
> to this bug, too.

Well it now boots :)
I'll let you know if there are any more problems with it in use.

-- 
----------(   "Clear?" - Holly. "No." - Lister. "Tough." -   )----------
Simon ----(                      Holly.                      )---- Nomis
                             Htag.pl 0.0.17
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
