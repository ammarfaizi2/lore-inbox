Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265939AbTAUHLC>; Tue, 21 Jan 2003 02:11:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266020AbTAUHLC>; Tue, 21 Jan 2003 02:11:02 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:55818 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265939AbTAUHLB>;
	Tue, 21 Jan 2003 02:11:01 -0500
Date: Mon, 20 Jan 2003 23:18:42 -0800
From: Greg KH <greg@kroah.com>
To: stanley.wang@linux.co.intel.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PCI_Hot_Plug_Discuss <pcihpd-discuss@lists.sourceforge.net>
Subject: Re: How about use sysfs instead of pcihpfs?
Message-ID: <20030121071842.GA28595@kroah.com>
References: <Pine.LNX.4.44.0301201711480.2265-100000@manticore.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301201711480.2265-100000@manticore.sh.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2003 at 05:21:43PM +0800, stanley.wang@linux.co.intel.com wrote:
> Hi, Greg!
> After reading the pci_hotplug_core.c, I found there are many codes 
> that are used to implement the pcihpfs. And how about using sysfs instead
> of pcihpfs ? I think it could make the pci_hotplug_core.c smaller. Another
> pro is that we will nerver be bothered by the pcihpfs' bug.
> How you think about it?

I agree, pcihpfs should go away, and you should use sysfs instead.  It's
on my list of things to do, but pretty low on it right now :(

Any patches to do this would be greatly appreciated.

One nice side affect of a conversion to sysfs, would be that different
pci hotplug drivers would be able to create their own files for
different attributes very easily (I know the author of the IBM PCI
Hotplug driver would really like to do this.)

Good luck,

greg k-h
