Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269049AbTCAWYC>; Sat, 1 Mar 2003 17:24:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269050AbTCAWYC>; Sat, 1 Mar 2003 17:24:02 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:59916 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S269049AbTCAWYB>;
	Sat, 1 Mar 2003 17:24:01 -0500
Date: Sat, 1 Mar 2003 14:25:33 -0800
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [BK PATCH] PCI hotplug changes for 2.5.63
Message-ID: <20030301222533.GC1975@kroah.com>
References: <20030301213853.GA1975@kroah.com> <Pine.LNX.4.44.0303011357130.2079-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303011357130.2079-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 01, 2003 at 02:00:58PM -0800, Linus Torvalds wrote:
> 
> On Sat, 1 Mar 2003, Greg KH wrote:
> > 
> > It looks right to me, but I don't have a working cardbus machine at the
> > moment, so I can't test it, sorry.
> 
> I don't think this is right. When we unplug a device, we're unplugging it 
> whether it is unused or not, and pci_remove_device_safe() is the wrong 
> thing. It should use the "remove_behind_bridge()" thing, so I think 
> Russell's patch is closer to working, but that one looked like it will 
> certainly corrupt memory with any multi-function device, so I really would 
> want to see something that has actually been tested too.

Fair enough, I'll try to get my laptop up and running this evening and
test these changes out on it.

thanks,

greg k-h
