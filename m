Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267641AbTAXMM0>; Fri, 24 Jan 2003 07:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267642AbTAXMM0>; Fri, 24 Jan 2003 07:12:26 -0500
Received: from robur.slu.se ([130.238.98.12]:10502 "EHLO robur.slu.se")
	by vger.kernel.org with ESMTP id <S267641AbTAXMMZ>;
	Fri, 24 Jan 2003 07:12:25 -0500
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15921.12235.466188.987454@robur.slu.se>
Date: Fri, 24 Jan 2003 13:21:31 +0100
To: Ben Greear <greearb@candelatech.com>
Cc: Robert Olsson <Robert.Olsson@data.slu.se>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ksoftirqd_CPU0 spinning in 2.4.21-pre3
In-Reply-To: <3E30352F.1080100@candelatech.com>
References: <3E2EF490.20402@candelatech.com>
	<15920.796.897388.111085@robur.slu.se>
	<3E30352F.1080100@candelatech.com>
X-Mailer: VM 6.92 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ben Greear writes:

 > There was zero network load on the box.  I think there must be a bug in
 > my napi-ization of the tulip driver.  Since I coppied it almost verbatim
 > from your stuff, you might want to check too :)

 If there are no interrupts and ksoftirqd is spinning it smells like  
 dev->poll never calls netif_rx_complete() --> pure polling.

 Cheers.
						--ro
 
