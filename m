Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264961AbTIDNXa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 09:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264983AbTIDNXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 09:23:30 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:58837 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264961AbTIDNX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 09:23:29 -0400
Subject: Re: [PATCH] Fix SMP support on 3c527 net driver, take 2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Felipe W Damasio <felipewd@terra.com.br>
Cc: Richard Procter <rnp@paradise.net.nz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F573574.5060008@terra.com.br>
References: <Pine.LNX.4.21.0309041758250.284-100000@ps2.local>
	 <3F573574.5060008@terra.com.br>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062681740.21994.48.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Thu, 04 Sep 2003 14:22:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-09-04 at 13:52, Felipe W Damasio wrote:
> 	But I'm not sure on how we should go here: We go get the hold lock 
> right after 'status=inb(ioaddr+HOST_CMD)', so we can treat the 
> interrupt safely.
> 
> 	Although, there are some places that we do "wake_up (lp->event)", 

wake_up will not sleep, its safe from interrupts and with locks held.


