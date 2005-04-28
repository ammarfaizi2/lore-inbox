Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261997AbVD1JMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261997AbVD1JMk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 05:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbVD1JJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 05:09:11 -0400
Received: from baloney.puettmann.net ([194.97.54.34]:61089 "EHLO
	baloney.puettmann.net") by vger.kernel.org with ESMTP
	id S261717AbVD1JGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 05:06:17 -0400
Date: Thu, 28 Apr 2005 11:05:40 +0200
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11.7 kernel panic on boot on AMD64
Message-ID: <20050428090539.GA18972@puettmann.net>
References: <20050427140342.GG10685@puettmann.net> <20050427152704.632a9317.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050427152704.632a9317.rddunlap@osdl.org>
User-Agent: Mutt/1.5.9i
From: Ruben Puettmann <ruben@puettmann.net>
X-Scanner: exiscan *1DR4xo-0004wL-00*DgzDCF67K6Q* (Puettmann.NeT, Germany)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2005 at 03:27:04PM -0700, Randy.Dunlap wrote:
 Looks like this code in init/main.c:
> 
> 	if (late_time_init)
> 		late_time_init();
> 
> sees a garbage value in late_time_init (garbage being
> %eax == 0x00307974.743d656c, which is "le=tty0\n",
> as in "console=tty0").
> 
> How long is your kernel boot/command line?
> Please post it.

It was boot over pxe here is the append line from the
pxelinux.cfg/default  

APPEND vga=normal rw  load_ramdisk=0 root=/dev/nfs nfsroot=192.168.112.1:/store/rescue/sarge-amd64,rsize=8192,wsize=8192,timo=12,retrans=3,mountvers=3,nfsvers=3


                       Ruben

-- 
Ruben Puettmann
ruben@puettmann.net
http://www.puettmann.net
