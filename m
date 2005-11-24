Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbVKXNM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbVKXNM5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 08:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbVKXNM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 08:12:56 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:13192 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750778AbVKXNMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 08:12:55 -0500
Subject: Re: [patch] SMP alternatives
From: Arjan van de Ven <arjan@infradead.org>
To: =?ISO-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Daniel Jacobowitz <dan@debian.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
       Andi Kleen <ak@suse.de>, Gerd Knorr <kraxel@suse.de>,
       Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <4385B9BB.7020007@draigBrady.com>
References: <1132764133.7268.51.camel@localhost.localdomain>
	 <20051123163906.GF20775@brahms.suse.de>
	 <1132766489.7268.71.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org>
	 <4384AECC.1030403@zytor.com>
	 <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org>
	 <1132782245.13095.4.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0511231331040.13959@g5.osdl.org>
	 <20051123214835.GA24044@nevyn.them.org>
	 <Pine.LNX.4.64.0511231416490.13959@g5.osdl.org>
	 <20051123222056.GA25078@nevyn.them.org>
	 <Pine.LNX.4.64.0511231502250.13959@g5.osdl.org>
	 <4385B9BB.7020007@draigBrady.com>
Content-Type: text/plain
Date: Thu, 24 Nov 2005 14:12:07 +0100
Message-Id: <1132837928.2832.33.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Just a note to say glibc is getting better wrt to locking.
> Compare the results and trival test program here:
> http://lkml.org/lkml/2001/12/7/75
> That showed that for glibc 2.2.4, getc & putc
> were 669% slower than the unlocked versions.
> 
> 4 years later and with 2.3.5-1ubuntu1, getc & putc
> are only 230% slower than the unlocked versions:
> 
> $ dd bs=1MB count=100 if=/dev/zero | ./locked >/dev/null
> 100000000 bytes transferred in 3.709362 seconds (26958813 bytes/sec)
> $ dd bs=1MB count=100 if=/dev/zero | ./unlocked >/dev/null
> 100000000 bytes transferred in 1.602427 seconds (62405339 bytes/sec)

this could also mean that the unlocked version has gotten slower ;)



