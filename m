Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030627AbWKOQIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030627AbWKOQIe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 11:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030626AbWKOQIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 11:08:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14302 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030627AbWKOQId (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 11:08:33 -0500
Date: Wed, 15 Nov 2006 07:52:41 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz,
       Komuro <komurojun-mbn@nifty.com>,
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
Subject: Re: 2.6.19-rc5: known regressions (v3)
Message-ID: <20061115075241.64ce1b7c@localhost.localdomain>
In-Reply-To: <20061115102122.GQ22565@stusta.de>
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
	<20061115102122.GQ22565@stusta.de>
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Subject    : PCI MSI setting corrupted during resume
> References : http://bugzilla.kernel.org/show_bug.cgi?id=7479
> Submitter  : Stephen Hemminger <shemminger@osdl.org>
> Status     : unknown
> 
Turns out this isn't a regression, it was always there. It has to do with ACPI
clearing state on resume. MSI wasn't being used the same in older kernels so
it didn't show up.
