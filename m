Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933814AbWKTAsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933814AbWKTAsi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 19:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933815AbWKTAsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 19:48:38 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:22955 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S933814AbWKTAsh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 19:48:37 -0500
Date: Mon, 20 Nov 2006 00:54:04 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@redhat.com>
Cc: David Rientjes <rientjes@cs.washington.edu>,
       Dave Jones <davej@codemonkey.org.uk>, Hiroshi Miura <miura@da-cha.org>,
       Zwane Mwaikambo <zwane@commfireservices.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 cpufreq: cs5530A allows active idle
Message-ID: <20061120005404.38c1e181@localhost.localdomain>
In-Reply-To: <20061119205503.GB1832@redhat.com>
References: <Pine.LNX.4.64N.0611191121050.391@attu4.cs.washington.edu>
	<20061119205503.GB1832@redhat.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Nov 2006 15:55:03 -0500
Dave Jones <davej@redhat.com> wrote:

> On Sun, Nov 19, 2006 at 11:24:08AM -0800, David Rientjes wrote:
>  > The cs5530A will be able to go into active idle (PWRSVE) so its PCI class 
>  > revision should be accurately stored.
> 
> Already queued in cpufreq.git for .20

CS5530 doesn't currently work correctly with suspend/resume anyway - you
need to restore the various SMM setups that are lost such as the VGA SMM
trap bit.

Alan
