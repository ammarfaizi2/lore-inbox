Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318231AbSIFBld>; Thu, 5 Sep 2002 21:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318234AbSIFBld>; Thu, 5 Sep 2002 21:41:33 -0400
Received: from dp.samba.org ([66.70.73.150]:23987 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S318231AbSIFBld>;
	Thu, 5 Sep 2002 21:41:33 -0400
Date: Fri, 6 Sep 2002 11:21:44 +1000
From: Anton Blanchard <anton@samba.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.4.20-pre5] non syscall gettimeofday
Message-ID: <20020906012144.GA6804@krispykreme>
References: <1031267553.10830.71.camel@dell_ss3.pdx.osdl.net> <al8ptr$up3$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <al8ptr$up3$1@cesium.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This sounds like a vsyscall.  Since we have discussed vsyscalls on and
> off without getting anywhere, I'd like to know how your implementation
> does it -- the #1 proposal I think was to map in a page at 0xfffff000
> and have the vsyscall code there.

Id like to do a similar thing on ppc32 and ppc64. It would be good to
make some of this generic before everyone implements it their own way.

Of course the lower level stuff will be arch specific, but some of it
could be the same (like how do we handle ptracing into the area? Do
we COW or do we deny it and fix gdb to unsderstand vsyscalls).

Anton
