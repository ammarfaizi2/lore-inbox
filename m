Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319036AbSHFJ50>; Tue, 6 Aug 2002 05:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319037AbSHFJ50>; Tue, 6 Aug 2002 05:57:26 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:19215 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S319036AbSHFJ5Z>;
	Tue, 6 Aug 2002 05:57:25 -0400
Date: Tue, 6 Aug 2002 12:01:01 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Thomas Mierau <tmi@wikon.de>
Cc: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-ac4 IRQ messup?
Message-ID: <20020806100101.GA20758@alpha.home.local>
References: <Pine.LNX.4.44.0208052251170.21076-100000@korben.citd.de> <200208061014.13619.tmi@wikon.de> <20020806083943.GA32229@alpha.home.local> <200208061139.35323.tmi@wikon.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208061139.35323.tmi@wikon.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2002 at 11:39:43AM +0200, Thomas Mierau wrote:
> Thanks,
> I looked it up its called watchdog (what else). It was set to 5000ms and I 
> changed it to 300ms. But the result is : no change!

by "no change", you mean "still loss of 5s" ?
If this is the case, are you sure the switch port you are connected to is
in full duplex too ? does it detect receive errors or carrier lost ? I
believe that cisco switches in "spanning tree portfast" mode block the port
during 5s after a renegociation. It's easy to detect because the port's led
becomes orange.

perhaps you can switch the 2 NIC's cables to check if the problem follows the 
cable or the NIC.

else I have no other clue ...

Regards,
Willy

