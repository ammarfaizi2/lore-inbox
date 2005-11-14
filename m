Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbVKNHqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbVKNHqj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 02:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbVKNHqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 02:46:39 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:63429 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750958AbVKNHqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 02:46:38 -0500
Subject: Re: [PATCH 1/10] Cr4 is valid on some 486s
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>,
       Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1131917530.25311.27.camel@localhost.localdomain>
References: <200511100032.jAA0WgUq027712@zach-dev.vmware.com>
	 <p734q6g4xuc.fsf@verdi.suse.de>
	 <1131902775.25311.16.camel@localhost.localdomain>
	 <200511132000.45836.ak@suse.de>
	 <1131910902.25311.21.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0511131130370.3263@g5.osdl.org>
	 <1131917530.25311.27.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 14 Nov 2005 08:46:13 +0100
Message-Id: <1131954373.2821.1.camel@laptopd505.fenrus.org>
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

On Sun, 2005-11-13 at 21:32 +0000, Alan Cox wrote:
> On Sul, 2005-11-13 at 11:36 -0800, Linus Torvalds wrote:
> > The thing is, we wouldn't ever remove _all_ lock prefixes. Only the ones 
> > that already depend on SMP.
> > 
> > So the memory barriers etc that have lock prefixes even on UP would be 
> > totally untouched.
> 
> That much makes sense. Having some magic MSR reloaded to turn lock
> effects off is a bit more of a problem for ECC scrubbing however.

well... you can expect many bioses to have done the MSR hack for you
already... so if you can't cope with that you have to set the MSR to the
value you want it to have regardless.


