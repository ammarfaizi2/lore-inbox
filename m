Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbTHaAsK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 20:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262281AbTHaAsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 20:48:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64161 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262280AbTHaAsH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 20:48:07 -0400
Message-ID: <3F5145BB.5080906@pobox.com>
Date: Sat, 30 Aug 2003 20:47:55 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Marcelo Tosatti <marcelo@parcelfarce.linux.theplanet.co.uk>,
       "J.A. Magallon" <jamagallon@able.es>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] check_gcc for i386
References: <Pine.LNX.4.44.0308301957440.20117-100000@logos.cnet> <1062286661.31332.8.camel@dhcp23.swansea.linux.org.uk>
In-Reply-To: <1062286661.31332.8.camel@dhcp23.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Sad, 2003-08-30 at 23:58, Marcelo Tosatti wrote:
> 
>>> ifdef CONFIG_MPENTIUM4
>>>-CFLAGS += -march=i686
>>>+CFLAGS += $(call check_gcc,-march=pentium4,-march=i686)
>>> endif
>>> 
>>> ifdef CONFIG_MK6
>>
>>OK, I forgot what that does. Can you please explain in detail what 
>>check_gcc does. 
> 
> 
> Tries to use gcc with the options given and if not falls back to the
> second set suggested. So it'll try -march=pentium4 (new gcc) and 
> fall back to -march=i686


Yep.  I introduced check_gcc into 2.4 (backported from 2.5), in fact.

The above change does exactly what Alan describes, and is a patch I was 
planning to submit myself :)  I did not want to change compiler options 
at the time when I submitted the check_gcc patch, but after many months 
of manually patching to get the best compiler flags, it seems solid.

	Jeff



