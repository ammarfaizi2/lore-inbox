Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264792AbSJOUsF>; Tue, 15 Oct 2002 16:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264805AbSJOUsF>; Tue, 15 Oct 2002 16:48:05 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:23305 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264792AbSJOUsD>;
	Tue, 15 Oct 2002 16:48:03 -0400
Date: Tue, 15 Oct 2002 13:54:02 -0700
From: Greg KH <greg@kroah.com>
To: Steven Dake <sdake@mvista.com>
Cc: Michael Clark <michael@metaparadigm.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] [PATCHES] Advanced TCA Hotswap Support in Linux Kernel
Message-ID: <20021015205402.GL15864@kroah.com>
References: <3DAB1007.6040400@mvista.com> <20021015052916.GA11190@kroah.com> <3DAC52A7.907@mvista.com> <3DAC685B.9070102@metaparadigm.com> <3DAC6C7B.1080205@mvista.com> <20021015203423.GI15864@kroah.com> <3DAC7EAA.5020408@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DAC7EAA.5020408@mvista.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 01:46:34PM -0700, Steven Dake wrote:
> The data/telecoms I've talked to require disk hotswap times of less then 
> 20 msec from notification of hotwap to blue led (a light used to 
> indicate the device can be removed).  They would like 10 msec if it 
> could be done.  This is because of how long it takes on a surprise 
> extraction for the hardware to send the signal vs the user to disconnect 
> the hardware.

But what starts the "notification of hotswap"?  Is this driven by the
user somehow, or is it a hardware event that happens out of the blue?

> For legacy systems such as SAFTE hotswap, polling through sg at 10 msec 
> intervals would be extremely painful because of all the context 
> switches.  A timer scheduled every 10 msec to send out a SCSI message 
> and handle a response if there is a hotswap event is a much better course.

What generates the hotswap event?

thanks,

greg k-h
