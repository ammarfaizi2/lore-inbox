Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbUBYDNw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 22:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbUBYDNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 22:13:51 -0500
Received: from farley.sventech.com ([69.36.241.87]:25005 "EHLO
	farley.sventech.com") by vger.kernel.org with ESMTP id S262426AbUBYDNt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 22:13:49 -0500
Date: Tue, 24 Feb 2004 19:13:48 -0800
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Dave Jones <davej@redhat.com>, greg@kroah.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: usb-uhci rmmod fun
Message-ID: <20040225031348.GM16632@sventech.com>
References: <20040225005241.GB11203@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040225005241.GB11203@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004, Dave Jones <davej@redhat.com> wrote:
> Greg,
>  wtf is going on here ?
> 
> (00:52:08:root@mindphaser:davej)# lsmod | grep floppy
> (00:52:39:root@mindphaser:davej)# modprobe usb-uhci
> (00:52:48:root@mindphaser:davej)# lsmod | grep floppy
> (00:53:02:root@mindphaser:davej)# rmmod uhci_hcd
> (00:53:11:root@mindphaser:davej)# lsmod | grep floppy
> floppy                 58260  0
> (00:53:13:root@mindphaser:davej)#
> 
> Unloading the usb controller loads the floppy controller!?

That can't be right. You're loading usb-uhci, then unloading uhci_hcd.

You should have only have one, depending on the version of the kernel.

JE

