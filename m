Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311856AbSD2OPr>; Mon, 29 Apr 2002 10:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312119AbSD2OPq>; Mon, 29 Apr 2002 10:15:46 -0400
Received: from 213-96-224-204.uc.nombres.ttd.es ([213.96.224.204]:42765 "EHLO
	manty.net") by vger.kernel.org with ESMTP id <S311856AbSD2OPp>;
	Mon, 29 Apr 2002 10:15:45 -0400
Date: Mon, 29 Apr 2002 16:15:43 +0200
From: Santiago Garcia Mantinan <manty@manty.net>
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pcnet32 on 2.4.18 doesn't init on IBM rs/6000 B50 (powerpc)
Message-ID: <20020429141543.GA3374@man.beta.es>
In-Reply-To: <20020425220402.GA3654@man.beta.es> <20020425221519.GA13245@krispykreme> <20020428153253.GA2924@man.beta.es> <20020428230707.GG17500@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you send me the version of OF you are using? You should be able to get
> it off the bootup splash screen or by doing lsprop /proc/device-tree/openprom.
> Do you get any errors in dmesg when the card stuffs up?

Umm, I don't have that lsprop installed, let's see if this is enough:

cat /proc/device-tree/openprom/ibm,fw-vernum_encoded
TCP00032
cat /proc/device-tree/openprom/ibm,loc-code
P1
cat /proc/device-tree/openprom/model
IBM,TCP00032
cat /proc/device-tree/openprom/name
openprom

> One thing to watch out for with the RS/6000 OF is that it wont reply
> to ARP messages during a TFTP load. If you are trying to load a
> big image you need to arp -s <hostname> <hw_addr>.

Ah, that could be it, yes.

But this doesn't explain the problem we are having with the card under linux
once we boot from the net ;-)

Thanks again!

Regards...
-- 
Manty/BestiaTester -> http://manty.net
