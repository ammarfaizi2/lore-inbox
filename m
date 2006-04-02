Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbWDBNQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbWDBNQA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 09:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbWDBNQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 09:16:00 -0400
Received: from morbo.e-centre.net ([66.154.82.3]:52201 "EHLO
	cubert.e-centre.net") by vger.kernel.org with ESMTP id S932336AbWDBNP7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 09:15:59 -0400
X-ASG-Debug-ID: 1143983744-10189-35-0
X-Barracuda-URL: http://10.3.1.19:8000/cgi-bin/mark.cgi
X-ASG-Orig-Subj: Re: [PATCH 1/1] POWERPC: Fix ppc32 compile with gcc+SSP in 2.6.16
Subject: Re: [PATCH 1/1] POWERPC: Fix ppc32 compile with gcc+SSP in 2.6.16
From: Arjan van de Ven <arjan@infradead.org>
To: John Mylchreest <johnm@gentoo.org>
Cc: Olaf Hering <olh@suse.de>, linux-kernel@vger.kernel.org, stable@kernel.org,
       paulus@samba.org
In-Reply-To: <20060402112002.GA3443@getafix.willow.local>
References: <20060401224849.GH16917@getafix.willow.local>
	 <20060402085850.GA28857@suse.de>
	 <20060402102259.GM16917@getafix.willow.local>
	 <20060402102815.GA29717@suse.de>
	 <20060402105859.GN16917@getafix.willow.local>
	 <20060402111002.GA30017@suse.de>
	 <20060402112002.GA3443@getafix.willow.local>
Content-Type: text/plain
Date: Sun, 02 Apr 2006 15:15:38 +0200
Message-Id: <1143983738.2994.18.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=4.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.10381
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Going from that, I can push a patch for gcc upstream to remove the
> __KERNEL__ dep, but gcc4.1 ships with ssp by standard, and the semantics
> between the IBM patch for SSP applied to gcc-3 and ggc-4 have changed.
> 
> -fno-stack-protector would work for gcc4, but for gcc3 it could still be

since this is a thing you have to turn on to get it, not off to not get
it, I think you're missing something big here ;)

> patially enabled, and requires -fno-stack-protector-all. Mind If I ask
> whats incorrect about defining __KERNEL__ for the bootcflags?

it's silly and it's a non-standard gcc ... better get the gcc fixed to
at least have the upstream protocol of having to turn it on not off..


