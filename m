Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272393AbRHYHEx>; Sat, 25 Aug 2001 03:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272394AbRHYHEo>; Sat, 25 Aug 2001 03:04:44 -0400
Received: from postfix2-1.free.fr ([213.228.0.9]:6919 "HELO postfix2-1.free.fr")
	by vger.kernel.org with SMTP id <S272393AbRHYHEf>;
	Sat, 25 Aug 2001 03:04:35 -0400
From: Willy Tarreau <wtarreau@free.fr>
Message-Id: <200108250704.f7P741U20873@ns.home.local>
Subject: Re: Poor Performance for ethernet bonding
To: greearb@candelatech.com
Date: Sat, 25 Aug 2001 09:04:00 +0200 (CEST)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

> Couldn't the bonding code be made to distribute pkts to one interface or
> another based on a hash of the sending IP port or something?  Seems like that
> would fix the reordering problem for IP packets....  It wouldn't help for
> a single stream, but I'm guessing the real world problem involves many streams,
> which on average should hash such that the load is balanced...

You may take a look at this for enhancements to the bonding driver :

  http://sourceforge.net/projects/bonding/

The XOR method has been implemented to hash the flows based on the SRC/DST
MAC addresses.

Regards,
Willy

