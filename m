Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932544AbVKWVhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbVKWVhX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 16:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbVKWVhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 16:37:23 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:46790 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932545AbVKWVhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 16:37:13 -0500
Subject: Re: [patch] SMP alternatives
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       "H. Peter Anvin" <hpa@zytor.com>, Gerd Knorr <kraxel@suse.de>,
       Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1132783540.13095.23.camel@localhost.localdomain>
References: <437B5A83.8090808@suse.de> <438359D7.7090308@suse.de>
	 <p7364qjjhqx.fsf@verdi.suse.de>
	 <1132764133.7268.51.camel@localhost.localdomain>
	 <20051123163906.GF20775@brahms.suse.de>
	 <1132766489.7268.71.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org>
	 <4384AECC.1030403@zytor.com>
	 <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org>
	 <1132782245.13095.4.camel@localhost.localdomain>
	 <20051123211353.GR20775@brahms.suse.de>
	 <1132783540.13095.23.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 23 Nov 2005 22:36:35 +0100
Message-Id: <1132781796.2795.76.camel@laptopd505.fenrus.org>
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


> CPU insert/remove is performed how many times a second ? Or for that
> matter why not just reload the PAT register and keep the index the
> same ?

you also want this for single threaded apps, so that the glibc locking
stuff can not do lock for single-threaded apps and non-shared memory


