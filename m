Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262956AbTEBPpP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 11:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262957AbTEBPpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 11:45:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28315 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262956AbTEBPpN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 11:45:13 -0400
Message-ID: <3EB29566.4000903@pobox.com>
Date: Fri, 02 May 2003 11:57:26 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Jeff Muizelaar <muizelaar@rogers.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] NE2000 driver updates
References: <3EB15127.2060409@rogers.com>	 <1051817031.21546.23.camel@dhcp22.swansea.linux.org.uk>	 <3EB1ADEC.6080007@rogers.com> <1051884070.23249.4.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1051884070.23249.4.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Gwe, 2003-05-02 at 00:29, Jeff Muizelaar wrote:
> 
>>Are we stuck with Space.c forever? Anyone have any plans for replacing 
>>it with something more driver-model friendly?
> 
> 
> Is it worth the effort. Why not just let the old isa stuff live out its
> life in peace ?


I'm glad you asked.  :)

For the major families of ISA net drivers, I am craving massive 
consolidation.  People continue to use this stuff in embedded systems 
and simulators, long past when the original cards disappear into the 
ether, too.  Considering that operations are inevitably IO bound, I am 
even willing to spend a few (admittedly costly) extra cycles chasing 
some additional function pointer de-refs, if we could massively shrink 
the size and number of NE2000/lance/82596 drivers out there.

I guarantee these drivers are gonna be with us for many years to come, 
and designers wanting to bang out a quick-and-easy MAC will create Yet 
Another NE2000 Clone.[1]

Did I mention that a GIGE ne2000 card exists?

	Jeff



[1] of course, with decent, free MAC and PHY cores at www.opencores.org, 
maybe we can convince hardware makers to use a better design.  </plug>

