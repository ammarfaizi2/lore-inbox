Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264750AbSJPA73>; Tue, 15 Oct 2002 20:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264763AbSJPA73>; Tue, 15 Oct 2002 20:59:29 -0400
Received: from [203.117.131.12] ([203.117.131.12]:42394 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S264750AbSJPA72>; Tue, 15 Oct 2002 20:59:28 -0400
Message-ID: <3DACBB4E.8090708@metaparadigm.com>
Date: Wed, 16 Oct 2002 09:05:18 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Steven Dake <sdake@mvista.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] [PATCHES] Advanced TCA Hotswap Support in Linux Kernel
References: <3DAB1007.6040400@mvista.com> <20021015052916.GA11190@kroah.com> <3DAC52A7.907@mvista.com> <3DAC685B.9070102@metaparadigm.com> <3DAC6C7B.1080205@mvista.com> <20021015203423.GI15864@kroah.com> <3DAC7EAA.5020408@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/02 04:46, Steven Dake wrote:
> The data/telecoms I've talked to require disk hotswap times of less then 
> 20 msec from notification of hotwap to blue led (a light used to 
> indicate the device can be removed).  They would like 10 msec if it 
> could be done.  This is because of how long it takes on a surprise 
> extraction for the hardware to send the signal vs the user to disconnect 
> the hardware.

I'm just surprised that the SAF-TE processers will respond this quickly.

> For legacy systems such as SAFTE hotswap, polling through sg at 10 msec 
> intervals would be extremely painful because of all the context 
> switches.  A timer scheduled every 10 msec to send out a SCSI message 
> and handle a response if there is a hotswap event is a much better course.

100 context switchs a second isn't that much is it?

I'll adjust safte-monitor from its default 2 second polling down
to 10msec and see what the result is.

~mc

