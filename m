Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261574AbULISBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbULISBL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 13:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbULISBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 13:01:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16533 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261574AbULISA1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 13:00:27 -0500
Date: Wed, 8 Dec 2004 20:15:57 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Blizbor <kernel@globalintech.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [crash] 2.4.22 and Can't locate module char-major-30
Message-ID: <20041208221557.GA2403@dmt.cyclades>
References: <41B75D85.8060302@globalintech.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41B75D85.8060302@globalintech.pl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2004 at 09:01:09PM +0100, Blizbor wrote:
> I have defined "*.* /dev/pty/1" in the /etc/syslogd.conf and the last 
> line I saw before crash was
> 
> Dec  8 19:29:42 oracle-srv-03 modprobe: modprobe: Can't locate module 
> char-major-30

>From devices.txt:

 30 char        iBCS-2 compatibility devices
                  0 = /dev/socksys      Socket access
                  1 = /dev/spx          SVR3 local X interface
                  2 = /dev/inet/arp     Network access
                  2 = /dev/inet/icmp    Network access
                  2 = /dev/inet/ip      Network access
                  2 = /dev/inet/udp     Network access
                  2 = /dev/inet/tcp     Network access

                Additionally, iBCS-2 requires /dev/nfsd to be a link
                to /dev/socksys, and /dev/X0R to be a link to
                /dev/null.


You probably have some application trying to access this device(s).  Do you?

> Could these two things be related ?
>
> What can cause such a crash ?

It should not have nothing to do with the crash, did you get any oops or similar? 

> I have RH 9 with custom compiled kernel and it was working about 300 days
> without any problems.
> I'm using e100, ide, ext3, jfs and oracle 9i on this machine.

Suggest you to upgrade to a newer kernel. 
