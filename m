Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263316AbRFACH2>; Thu, 31 May 2001 22:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263313AbRFACHI>; Thu, 31 May 2001 22:07:08 -0400
Received: from line128.ba.psg.sk ([195.80.179.128]:39552 "HELO ivan.doma")
	by vger.kernel.org with SMTP id <S263317AbRFACHE>;
	Thu, 31 May 2001 22:07:04 -0400
Date: Fri, 1 Jun 2001 04:06:27 +0200
From: Ivan <pivo@pobox.sk>
To: linux-kernel@vger.kernel.org
Subject: PID of init != 1 when initrd with pivot_root
Message-ID: <20010601040627.A1335@ivan.doma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I upgraded and found pivot_root and the problem is that how do I make init
run with PID 1. My linuxrc gets PID 7.

    1 ?        00:03:05 swapper
    2 ?        00:00:00 keventd
    3 ?        00:00:00 kswapd
    4 ?        00:00:00 kreclaimd
    5 ?        00:00:00 bdflush
    6 ?        00:00:00 kupdated
    7 ?        00:00:00 linuxrc

init doesn't like running with any other PID than 1. I could probably revert to
the not so old way of doing things and exit linuxrc and let the kernel change
root. But then I wouldn't be able to mount root over samba :-(. ( not that I
have any samba shares :-)

Ivan Vadovic
