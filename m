Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964775AbVKOQIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbVKOQIq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 11:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932533AbVKOQIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 11:08:46 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:55981 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932548AbVKOQIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 11:08:45 -0500
To: Gerd Knorr <kraxel@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/10] Cr4 is valid on some 486s
X-Message-Flag: Warning: May contain useful information
References: <200511100032.jAA0WgUq027712@zach-dev.vmware.com>
	<20051111103605.GC27805@elf.ucw.cz> <4374F2D5.7010106@vmware.com>
	<Pine.LNX.4.64.0511111147390.4627@g5.osdl.org>
	<4374FB89.6000304@vmware.com>
	<Pine.LNX.4.64.0511111218110.4627@g5.osdl.org>
	<20051113074241.GA29796@redhat.com>
	<Pine.LNX.4.64.0511131118020.3263@g5.osdl.org>
	<Pine.LNX.4.64.0511131210570.3263@g5.osdl.org>
	<4378A7F3.9070704@suse.de>
	<Pine.LNX.4.64.0511141118000.3263@g5.osdl.org>
	<4379ECC1.20005@suse.de> <437A0649.7010702@suse.de>
From: Roland Dreier <rolandd@cisco.com>
Date: Tue, 15 Nov 2005 08:08:24 -0800
In-Reply-To: <437A0649.7010702@suse.de> (Gerd Knorr's message of "Tue, 15
 Nov 2005 17:01:13 +0100")
Message-ID: <52r79h7v2f.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 15 Nov 2005 16:08:26.0255 (UTC) FILETIME=[CF85E1F0:01C5E9FE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    > +#define alternative_smp(smpinstr, upinstr) asm(upinstr, ##input)

this wouldn't build with CONFIG_SMP=n -- you forgot the input param here.

also, given this:

    > +		BUG_ON(a->replacementlen > a->instrlen); 

is there any way to at least catch it at compile time if the UP
alternative ends up longer than the SMP alternative?

 - R.
