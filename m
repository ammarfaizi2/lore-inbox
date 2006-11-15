Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966763AbWKOKgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966763AbWKOKgF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 05:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966761AbWKOKfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 05:35:50 -0500
Received: from pfx2.jmh.fr ([194.153.89.55]:35469 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S966760AbWKOKft (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 05:35:49 -0500
From: Eric Dumazet <dada1@cosmosbay.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.19-rc5: known regressions (v3)
Date: Wed, 15 Nov 2006 11:35:46 +0100
User-Agent: KMail/1.9.5
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Stephen Hemminger <shemminger@osdl.org>, gregkh@suse.de,
       linux-pci@atrey.karlin.mff.cuni.cz, Komuro <komurojun-mbn@nifty.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@redhat.com>, Ernst Herzberg <earny@net4u.de>,
       Len Brown <len.brown@intel.com>, Andre Noll <maan@systemlinux.org>,
       Andi Kleen <ak@suse.de>, discuss@x86-64.org,
       Prakash Punnoor <prakash@punnoor.de>, phil.el@wanadoo.fr,
       oprofile-list@lists.sourceforge.net,
       Alex Romosan <romosan@sycorax.lbl.gov>,
       Jens Axboe <jens.axboe@oracle.com>,
       Andrey Borzenkov <arvidjaar@mail.ru>,
       Alan Stern <stern@rowland.harvard.edu>,
       linux-usb-devel@lists.sourceforge.net
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org> <20061115102122.GQ22565@stusta.de>
In-Reply-To: <20061115102122.GQ22565@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611151135.48306.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 November 2006 11:21, Adrian Bunk wrote:

> Subject    : x86_64: oprofile doesn't work
> References : http://lkml.org/lkml/2006/10/27/3
> Submitter  : Prakash Punnoor <prakash@punnoor.de>
> Status     : unknown
>

I confirm a got this one too.
On a working kernel on an Opteron, we have normally 4 directories 
in /dev/oprofile :

# ls -ld /dev/oprofile/?
drwxr-xr-x 1 root root 0 15. Nov 12:38 /dev/oprofile/0
drwxr-xr-x 1 root root 0 15. Nov 12:38 /dev/oprofile/1
drwxr-xr-x 1 root root 0 15. Nov 12:38 /dev/oprofile/2
drwxr-xr-x 1 root root 0 15. Nov 12:38 /dev/oprofile/3

With linux-2.6.19-rc5, the first one (0) is missing and we get 1,2,3

Maybe the 'bug' is in oprofile tools, that currently expect to find '0'

Eric
