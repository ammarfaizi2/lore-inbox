Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261296AbSI3UQ6>; Mon, 30 Sep 2002 16:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261301AbSI3UQ6>; Mon, 30 Sep 2002 16:16:58 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1295 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261296AbSI3UQ5>;
	Mon, 30 Sep 2002 16:16:57 -0400
Message-ID: <3D98B25E.2010408@pobox.com>
Date: Mon, 30 Sep 2002 16:21:50 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kent Yoder <key@austin.ibm.com>
CC: linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de
Subject: Re: [PATCH] pcnet32 cable status check
References: <Pine.LNX.4.44.0209301421100.13906-100000@ennui.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Comments:

It looks good as a starting point :)

I just added mii_check_media() to drivers/net/mii.c.  It's in the latest 
2.5.x snapshot, 
ftp://ftp.kernel.org/pub/linux/kernel/v2.5/snapshots/patch-2.5.39-bk2.bz2

and is in Marcelo's inbox as well.  For simple implementations (and I 
think pcnet32 qualifies), the timer should not need to do anything 
beyond calling mii_check_media().  One important feature of this is use 
of the standard netif_carrier_{off,on} to indicate link to the system. 
netif_carrier_xxx also means you don't need lp->link...

