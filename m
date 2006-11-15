Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966771AbWKOKun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966771AbWKOKun (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 05:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966770AbWKOKun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 05:50:43 -0500
Received: from mail.suse.de ([195.135.220.2]:27306 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S966771AbWKOKun (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 05:50:43 -0500
From: Andi Kleen <ak@suse.de>
To: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: 2.6.19-rc5: known regressions (v3)
Date: Wed, 15 Nov 2006 11:50:10 +0100
User-Agent: KMail/1.9.5
Cc: Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Stephen Hemminger <shemminger@osdl.org>, gregkh@suse.de,
       linux-pci@atrey.karlin.mff.cuni.cz, Komuro <komurojun-mbn@nifty.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@redhat.com>, Ernst Herzberg <earny@net4u.de>,
       Len Brown <len.brown@intel.com>, Andre Noll <maan@systemlinux.org>,
       discuss@x86-64.org, Prakash Punnoor <prakash@punnoor.de>,
       phil.el@wanadoo.fr, oprofile-list@lists.sourceforge.net,
       Alex Romosan <romosan@sycorax.lbl.gov>,
       Jens Axboe <jens.axboe@oracle.com>,
       Andrey Borzenkov <arvidjaar@mail.ru>,
       Alan Stern <stern@rowland.harvard.edu>,
       linux-usb-devel@lists.sourceforge.net
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org> <20061115102122.GQ22565@stusta.de> <200611151135.48306.dada1@cosmosbay.com>
In-Reply-To: <200611151135.48306.dada1@cosmosbay.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611151150.11275.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On a working kernel on an Opteron, we have normally 4 directories 
> in /dev/oprofile :
> 
> # ls -ld /dev/oprofile/?
> drwxr-xr-x 1 root root 0 15. Nov 12:38 /dev/oprofile/0
> drwxr-xr-x 1 root root 0 15. Nov 12:38 /dev/oprofile/1
> drwxr-xr-x 1 root root 0 15. Nov 12:38 /dev/oprofile/2
> drwxr-xr-x 1 root root 0 15. Nov 12:38 /dev/oprofile/3
> 
> With linux-2.6.19-rc5, the first one (0) is missing and we get 1,2,3

That's because 0 was never available. It is used by the NMI watchdog.
The new kernel doesn't give it to oprofile anymore.

> Maybe the 'bug' is in oprofile tools, that currently expect to find '0'

Yes, it's likely a user space issue.

-Andi

