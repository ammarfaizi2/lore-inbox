Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262945AbSJBDSs>; Tue, 1 Oct 2002 23:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262948AbSJBDSr>; Tue, 1 Oct 2002 23:18:47 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:52744 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262945AbSJBDSo>;
	Tue, 1 Oct 2002 23:18:44 -0400
Date: Tue, 1 Oct 2002 20:21:43 -0700
From: Greg KH <greg@kroah.com>
To: Krishnakumar B <kitty@cse.wustl.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb-uhci renamed under Linux-2.5.40
Message-ID: <20021002032142.GA11871@kroah.com>
References: <15770.25006.908775.563421@samba.doc.wustl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15770.25006.908775.563421@samba.doc.wustl.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 10:02:06PM -0500, Krishnakumar B wrote:
> Hi,
> 
> When building Linux-2.5.40, I noted that usb-uhci is renamed to (or maybe a
> complete reimplementation) uhci-hcd. How can I set up /etc/modules.conf so
> that depending on the kernel that I am running either usb-uhci (2.4.x) or
> uhci-hcd (2.5.x) is chosen for the usb-controller ? Is there some simple
> alias trick that I am missing ? Is it possible for usb-uhci to be built
> with linux-2.5.x ? I didn't see any option when doing a build from scratch
> (make mrproper menuconfig).

The uhci change happened a long time ago :)
And yes, it's a new implementation.

Here's what's in my modules.conf that allows me to run properly for both
2.4 and 2.5:
	alias usb-controller usb-uhci
	alias usb-controller1 usb-ohci
	alias usb-controller2 uhci-hcd
	alias usb-controller3 ohci-hcd

Hope this helps,

greg k-h
