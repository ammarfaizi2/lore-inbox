Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbVKXCHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbVKXCHK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 21:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbVKXCHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 21:07:10 -0500
Received: from nevyn.them.org ([66.93.172.17]:65259 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S1751231AbVKXCG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 21:06:58 -0500
Date: Wed, 23 Nov 2005 21:06:46 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
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
Message-ID: <20051124020646.GA30379@nevyn.them.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@suse.de>,
	Gerd Knorr <kraxel@suse.de>, Dave Jones <davej@redhat.com>,
	Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Pratap Subrahmanyam <pratap@vmware.com>,
	Christopher Li <chrisl@vmware.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Ingo Molnar <mingo@elte.hu>
References: <4384AECC.1030403@zytor.com> <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org> <1132782245.13095.4.camel@localhost.localdomain> <Pine.LNX.4.64.0511231331040.13959@g5.osdl.org> <20051123214835.GA24044@nevyn.them.org> <Pine.LNX.4.64.0511231416490.13959@g5.osdl.org> <20051123222056.GA25078@nevyn.them.org> <Pine.LNX.4.64.0511231502250.13959@g5.osdl.org> <20051123234256.GA27337@nevyn.them.org> <Pine.LNX.4.64.0511231551470.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511231551470.13959@g5.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 03:59:52PM -0800, Linus Torvalds wrote:
> On Wed, 23 Nov 2005, Daniel Jacobowitz wrote:
> > 
> > Those are the wrong ways of doing this in userspace.  There are right
> > ways.  For instance, tag the binary at link time "single-threaded". 
> 
> And I mentioned exactly this. It's my third alternative.
> 
> And it doesn't work well, exactly because developers don't know if the 
> libraries they use are always single-threaded etc. More importantly, it 
> just doesn't happen that much. People do "make ; make install". Hopefully 
> from pretty standard sources. Having to tweak things so that a project 
> compiles with a magic flag on a particular distribution is simply not done 
> very much.

But distributors (Debian included) do this all the time :-)

I'd even volunteer to get it done and pushed out and in use, if I was
as convinced of the benefits.  For most applications, though, I'm still
sceptical.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
