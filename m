Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932594AbWBXWTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594AbWBXWTW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 17:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932606AbWBXWTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 17:19:22 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:57016 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932594AbWBXWTV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 17:19:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Hq58E++8VaLuF62AQqCgU7WBFmHPeTsdcmKc54xHN7fPpW26lrPqRQ34efYQmRKO1ZQEEPnVMvUkac2nBmUVbGA0VpV6w1e69g09cwi/RUcUaNY/z8vdbCy+fwEOw9dM/2joBjELd5WZOdJjieVTGaKs8LtpjLDjR6D7QoIWM4Q=
Message-ID: <12c511ca0602241419j312540b4ifb11dc1fa5f2247b@mail.gmail.com>
Date: Fri, 24 Feb 2006 14:19:20 -0800
From: "Tony Luck" <tony.luck@gmail.com>
To: "Arjan van de Ven" <arjan@linux.intel.com>
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
Cc: linux-kernel@vger.kernel.org, ak@suse.de, torvalds@osdl.org, akpm@osdl.org,
       mingo@elte.hu
In-Reply-To: <1140707358.4672.67.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1140700758.4672.51.camel@laptopd505.fenrus.org>
	 <1140707358.4672.67.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/06, Arjan van de Ven <arjan@linux.intel.com> wrote:
> As per previous discussions, Linus said he wanted a "static" list for this,
> eg a list provided by the kernel tarbal, so that most people have the same
> ordering at least. A script is provided to create this list based on
> readprofile(1) output. The included list is provisional, and entirely biased
> on my own testbox and me running a few kernel compiles and some other
> things.
>
> I think that to get to a better list we need to invite people to submit
> their own profiles, and somehow add those all up and base the final list on
> that.

1) How will this work in the face of CONFIG options that change the
list of symbols present in your kernel?  E.g. my hot oprofile list
might well contain a bunch of symbols from my NIC driver and whatever
filesystem I'm pounding on.

2) If you add enough lists from enough people, perhaps you'll get enough
coverage of the kernel with all their different workloads, that you'll have
too much to fit into the 2M page.

-Tony (Just joining in this thread for fun, ia64 pins all kernel text with a
single mapping, so we don't have any TLB misses at all :)
