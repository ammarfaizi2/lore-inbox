Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319217AbSHWTue>; Fri, 23 Aug 2002 15:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319262AbSHWTtY>; Fri, 23 Aug 2002 15:49:24 -0400
Received: from [195.39.17.254] ([195.39.17.254]:11904 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S319214AbSHWTtE>;
	Fri, 23 Aug 2002 15:49:04 -0400
Date: Fri, 2 Nov 2001 05:12:12 +0000
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Benjamin LaHaise <bcrl@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Pavel Machek <pavel@Elf.ucw.cz>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: aio-core why not using SuS? [Re: [rfc] aio-core for 2.5.29 (Re: async-io API registration for 2.5.29)]
Message-ID: <20011102051212.H35@toy.ucw.cz>
References: <2156501334.1029532543@[10.10.2.3]> <Pine.LNX.4.44.0208162134440.2497-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.44.0208162134440.2497-100000@home.transmeta.com>; from torvalds@transmeta.com on Fri, Aug 16, 2002 at 09:46:09PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> 
> But if you have such a mapping, then you _cannot_ make a per-task VM
> space, because many tasks will share the same VM. You cannot even do a
> per-cpu mapping change (and rewrite the VM on thread switch), since the VM
> is _shared_ across CPU's, and absolutely has to be in order to work with
> CPU's that do TLB fill in hardware (eg x86).

You could have different %cr3 on different CPUs and use page tables as TLBs
(emulating software-filled TLBs, basically); but that smells like "bye bye
performance".
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

