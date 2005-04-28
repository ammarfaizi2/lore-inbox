Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbVD1Gk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbVD1Gk7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 02:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVD1Gk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 02:40:58 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:59590 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261570AbVD1Gkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 02:40:53 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Joe <joecool1029@gmail.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: Device Node Issues with recent mm's and udev
Date: Thu, 28 Apr 2005 09:40:14 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
References: <d4757e6005042716523af66bae@mail.gmail.com> <20050427170106.782ea4c3.akpm@osdl.org> <d4757e600504271715493fd507@mail.gmail.com>
In-Reply-To: <d4757e600504271715493fd507@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504280940.15277.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 April 2005 03:15, Joe wrote:
> Ok, I will test when its out.
> 
> >Is the device node in /dev actually a block-special device, or is is coming
> >up as a regular file or something?
> 
> It appears as a special block device before an image is sent.  After
> that it appears as a regular file.

What does this mean, "image is sent"? Can you be more specific, like
"I do this: 'cp my_file /dev/sdb1'"

Also, watch logs closely, both syslog (where hotplug and udev are sending
their messages (btw hotplug is shell scripts, you may add debug messages
into them if you need to)), and kernel log.

You can also 'strace -p <pid of udevd>' and strace your cp or whatever
you use to copy image to device.
--
vda

