Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbWGSL4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWGSL4b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 07:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbWGSL4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 07:56:31 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:50566 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S964796AbWGSL4a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 07:56:30 -0400
Date: Wed, 19 Jul 2006 13:56:29 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: chinmaya@innomedia.soft.net
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Gettin own IP address thorugh ioctl in kernel space.
Message-ID: <20060719115629.GB22306@harddisk-recovery.com>
References: <44BDFC64.607@innomedia.soft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44BDFC64.607@innomedia.soft.net>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2006 at 03:03:24PM +0530, Chinmaya Mishra wrote:
> Can you provide an example how to invoke ioctl on
> device in kernel module.
> 
> For example. I want to find out the IP address of
> my eth0 and I want to make SIOCSIFADDR on it from 
> kernel module.

Sounds like a badly designed module. Do it from userspace.

> At user space i am doing it like this.....
> 
> unsigned long *ip;
> char *iface;
> int sockfd;
> struct ifreq ifr;
> strcpy(ifr.ifr_name, iface);	// interface name 'eth0'
> sockfd = socket(AF_INET,SOCK_DGRAM,0);
> ioctl(sockfd, SIOCGIFADDR, (char*)&ifr);
> memcpy(ip, &(ifr.ifr_addr.sa_data[2]),4); //Copy the ip addr
> close(sockfd);
> 
> How to port this in keernel space.

Not. For the same reasons why you shouldn't read files from kernel
space.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
