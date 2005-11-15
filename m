Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751432AbVKOQUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbVKOQUN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 11:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbVKOQUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 11:20:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47813 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751432AbVKOQUK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 11:20:10 -0500
Date: Tue, 15 Nov 2005 11:19:49 -0500
From: Dave Jones <davej@redhat.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Zachary Amsden <zach@vmware.com>,
       Gerd Knorr <kraxel@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/10] Cr4 is valid on some 486s
Message-ID: <20051115161949.GC1749@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Zachary Amsden <zach@vmware.com>, Gerd Knorr <kraxel@suse.de>,
	Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Pratap Subrahmanyam <pratap@vmware.com>,
	Christopher Li <chrisl@vmware.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Ingo Molnar <mingo@elte.hu>
References: <Pine.LNX.4.64.0511131118020.3263@g5.osdl.org> <Pine.LNX.4.64.0511131210570.3263@g5.osdl.org> <4378A7F3.9070704@suse.de> <Pine.LNX.4.64.0511141118000.3263@g5.osdl.org> <4379ECC1.20005@suse.de> <437A0649.7010702@suse.de> <437A0710.4020107@vmware.com> <1132070764.2822.27.camel@laptopd505.fenrus.org> <20051115161041.GA1749@redhat.com> <437A0965.7020909@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437A0965.7020909@zytor.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 08:14:29AM -0800, H. Peter Anvin wrote:
 > Dave Jones wrote:
 > >On Tue, Nov 15, 2005 at 05:06:03PM +0100, Arjan van de Ven wrote:
 > > 
 > > > > You still need to preserve the originals so that you can patch in 
 > > both > > directions.  
 > > > 
 > > > why do you insist on both directions? That still sounds like real
 > > > overkill to me.
 > >
 > >cpu hotplug going from UP to SMP ? :)
 > >
 > 
 > If you have CPU hotplug enabled, you can run SMP code!

Sure, but if you boot with 1 CPU, spinlocks get nop'd to emulate UP,
and on a 'installed a new cpu' hotplug event, they all come back.

		Dave

