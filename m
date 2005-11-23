Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbVKXAA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbVKXAA3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 19:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbVKXAA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 19:00:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49333 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932402AbVKXAAZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 19:00:25 -0500
Date: Wed, 23 Nov 2005 15:59:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Daniel Jacobowitz <dan@debian.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
       Andi Kleen <ak@suse.de>, Gerd Knorr <kraxel@suse.de>,
       Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
In-Reply-To: <20051123234256.GA27337@nevyn.them.org>
Message-ID: <Pine.LNX.4.64.0511231551470.13959@g5.osdl.org>
References: <1132766489.7268.71.camel@localhost.localdomain>
 <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org> <4384AECC.1030403@zytor.com>
 <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org> <1132782245.13095.4.camel@localhost.localdomain>
 <Pine.LNX.4.64.0511231331040.13959@g5.osdl.org> <20051123214835.GA24044@nevyn.them.org>
 <Pine.LNX.4.64.0511231416490.13959@g5.osdl.org> <20051123222056.GA25078@nevyn.them.org>
 <Pine.LNX.4.64.0511231502250.13959@g5.osdl.org> <20051123234256.GA27337@nevyn.them.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 Nov 2005, Daniel Jacobowitz wrote:
> 
> Those are the wrong ways of doing this in userspace.  There are right
> ways.  For instance, tag the binary at link time "single-threaded". 

And I mentioned exactly this. It's my third alternative.

And it doesn't work well, exactly because developers don't know if the 
libraries they use are always single-threaded etc. More importantly, it 
just doesn't happen that much. People do "make ; make install". Hopefully 
from pretty standard sources. Having to tweak things so that a project 
compiles with a magic flag on a particular distribution is simply not done 
very much.

			Linus
