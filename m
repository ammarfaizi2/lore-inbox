Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262469AbSKMSnu>; Wed, 13 Nov 2002 13:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262506AbSKMSnu>; Wed, 13 Nov 2002 13:43:50 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:58386 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262469AbSKMSnt>;
	Wed, 13 Nov 2002 13:43:49 -0500
Date: Wed, 13 Nov 2002 10:45:15 -0800
From: Greg KH <greg@kroah.com>
To: Ed Vance <EdV@macrolink.com>
Cc: "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: hotplug (was devfs)
Message-ID: <20021113184515.GE5446@kroah.com>
References: <11E89240C407D311958800A0C9ACF7D1A33CA8@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11E89240C407D311958800A0C9ACF7D1A33CA8@EXCHANGE>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2002 at 10:45:43AM -0800, Ed Vance wrote:
> On Wed, November 13, 2002 at 10:05 AM, Greg KH wrote: 
> > 
> > On Wed, Nov 13, 2002 at 06:06:06PM +0000, Nick Craig-Wood wrote:
> > > 
> > > So I'll be able to say usb bus1/1/4/1 port 3 should be /dev/ttyUSB15
> > > and it will always be that port?  That would be perfect.
> > 
> > Yes, that is the goal.
> > 
> 
> Do you expect that goal to eventually be applied to CompactPCI Hot-Swap
> bus/slot port 3?

Yes, in a round-about way.  If the device that is in that specific slot
with that specific port, registers with, for example, the network
subsystem, and we have decided that anything in that slot should be
called "eth42", then we can do that based on the topology of the device.

It really depends on the device that is existing in a specific location
(network, scsi, etc.) and not so much as the specific location will
always be a network card called "ethX", as you have to look at the type
of device too.

Does that make sense?

I can tell it's getting to be the time to start writing all of this down
for people to hash out... :)

thanks,

greg k-h
