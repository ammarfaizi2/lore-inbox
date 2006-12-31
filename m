Return-Path: <linux-kernel-owner+w=401wt.eu-S933171AbWLaNZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933171AbWLaNZj (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 08:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933172AbWLaNZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 08:25:39 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:52942 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933171AbWLaNZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 08:25:38 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Suspend problems on 2.6.20-rc2-git1
Date: Sun, 31 Dec 2006 14:27:01 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
References: <459771A2.6060301@shaw.ca>
In-Reply-To: <459771A2.6060301@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612311427.02175.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 31 December 2006 09:15, Robert Hancock wrote:
> Having some suspend problems on 2.6.20-rc2-git1 with Fedora Core 6. 
> First of all the normal user interface for hibernate isn't working 
> properly while it did in 2.6.19. When you select "Hibernate" it seems to 
> stop X and go into console mode but somehow doesn't seem to actually 
> start the process of suspending. I'm not sure at what point it is failing.
> 
> Secondly, if you try and suspend manually it claims there is no swap 
> device available when there clearly is:
> 
> [root@localhost rob]# cat /proc/swaps
> Filename                                Type            Size    Used 
> Priority
> /dev/mapper/VolGroup00-LogVol01         partition       1048568 0       -1
> [root@localhost rob]# echo disk > /sys/power/state
> bash: echo: write error: No such device or address

Hm, at first sight it looks like something broke the suspend to swap
partitions located on LVM.  For now I have no idea what it was.

Have you tried any kernels between 2.6.19 and 2.6.20-rc2-git1?

Greetings,
Rafael


-- 
If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King
