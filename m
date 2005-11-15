Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbVKOQGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbVKOQGk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 11:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964775AbVKOQGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 11:06:39 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:21954 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964773AbVKOQGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 11:06:38 -0500
Subject: Re: [PATCH 1/10] Cr4 is valid on some 486s
From: Arjan van de Ven <arjan@infradead.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Gerd Knorr <kraxel@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Dave Jones <davej@redhat.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <437A0710.4020107@vmware.com>
References: <200511100032.jAA0WgUq027712@zach-dev.vmware.com>
	 <20051111103605.GC27805@elf.ucw.cz> <4374F2D5.7010106@vmware.com>
	 <Pine.LNX.4.64.0511111147390.4627@g5.osdl.org>
	 <4374FB89.6000304@vmware.com>
	 <Pine.LNX.4.64.0511111218110.4627@g5.osdl.org>
	 <20051113074241.GA29796@redhat.com>
	 <Pine.LNX.4.64.0511131118020.3263@g5.osdl.org>
	 <Pine.LNX.4.64.0511131210570.3263@g5.osdl.org> <4378A7F3.9070704@suse.de>
	 <Pine.LNX.4.64.0511141118000.3263@g5.osdl.org> <4379ECC1.20005@suse.de>
	 <437A0649.7010702@suse.de>  <437A0710.4020107@vmware.com>
Content-Type: text/plain
Date: Tue, 15 Nov 2005 17:06:03 +0100
Message-Id: <1132070764.2822.27.camel@laptopd505.fenrus.org>
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

On Tue, 2005-11-15 at 08:04 -0800, Zachary Amsden wrote:
> Gerd Knorr wrote:
> 
> >> Yep, extending alternatives is probably better than duplicating the 
> >> code.  Maybe having some alternative_smp() macro which places both 
> >> code versions into the .altinstr_replacement table?  If that sounds 
> >> ok I'll try to come up with a experimental patch.
> >
> >
> > i.e. something like this (as basic idea, patch is far away from doing 
> > anything useful ...)?
> 
> 
> You still need to preserve the originals so that you can patch in both 
> directions.  

why do you insist on both directions? That still sounds like real
overkill to me.


