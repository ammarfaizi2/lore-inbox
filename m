Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262884AbTENVa1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 17:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbTENVa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 17:30:27 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:15110 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262884AbTENVa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 17:30:26 -0400
Date: Wed, 14 May 2003 22:43:10 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Pau Aliagas <linuxnow@newtral.org>
cc: lkml <linux-kernel@vger.kernel.org>,
       <viro@parcelfarce.linux.theplanet.co.uk>,
       Ahmed Masud <masud@googgun.com>, walt <wa1ter@myrealbox.com>
Subject: Re: cannot boot 2.5.69
In-Reply-To: <Pine.LNX.4.44.0305141734020.1872-100000@pau.intranet.ct>
Message-ID: <Pine.LNX.4.44.0305142241390.13403-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > > > > It reports: "no console found, specify init= option"
> 
> > What kind of console do you have configured in and what's your kernel
> > command line?
> 
> It's a Dell laptop, nothing special.
> 
> This is the relevant part of my config:
> CONFIG_VT_CONSOLE=y
> CONFIG_HW_CONSOLE=y
> # CONFIG_LP_CONSOLE is not set
> CONFIG_VGA_CONSOLE=y
> # CONFIG_MDA_CONSOLE is not set
> CONFIG_DUMMY_CONSOLE=y
> 
> And the part of /boot/grub/grub.conf:
> title Pau Linux (2.5.69)
>         root (hd0,0)
>         kernel /vmlinuz-2.5.69 ro root=/dev/hda1

Try using 

# CONFIG_DUMMY_CONSOLE is not set


Let me know if this works. Then try the latest BK tree. I sent in fix for 
the locking some dual headed systems where experiencing.
 

