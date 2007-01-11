Return-Path: <linux-kernel-owner+w=401wt.eu-S1030239AbXAKIuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030239AbXAKIuD (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 03:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030238AbXAKIuC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 03:50:02 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:35495 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030239AbXAKIuB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 03:50:01 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eh2XlRdmQq0iAEnnrRuYkLX+xEN0R30dxFbJq+wrDB813KG9Tw6QhtMt5/FgUtNepT9ZScCn1uojLyqSEi7FUIckhALti6BfKJzdNmCCJJeEvH5zdz2CIVzfKtFnQyC35iYh38ItKTmttthTVM2OWI+NkD1d4ulxb8jpHVh4jlM=
Message-ID: <afe668f90701110049m412a041awc1fd9a03660bec45@mail.gmail.com>
Date: Thu, 11 Jan 2007 16:49:59 +0800
From: "Roy Huang" <royhuang9@gmail.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Subject: Re: O_DIRECT question
Cc: Aubrey <aubreylee@gmail.com>, "Andrew Morton" <akpm@osdl.org>,
       "Linus Torvalds" <torvalds@osdl.org>, "Hua Zhong" <hzhong@gmail.com>,
       "Hugh Dickins" <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, kenneth.w.chen@intel.com, mjt@tls.msk.ru
In-Reply-To: <45A5F157.9030001@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>
	 <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org>
	 <6d6a94c50701102150w4c3b46d0w6981267e2b873d37@mail.gmail.com>
	 <20070110220603.f3685385.akpm@osdl.org>
	 <6d6a94c50701102245g6afe6aacxfcb2136baee5cbfa@mail.gmail.com>
	 <20070110225720.7a46e702.akpm@osdl.org>
	 <45A5E1B2.2050908@yahoo.com.au>
	 <6d6a94c50701102354l7ab41a3bp4761566204f1d992@mail.gmail.com>
	 <45A5F157.9030001@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is already an EMBEDDED option in config, so I think linux is
also supporting embedded system. There are many developers working on
embedded system runing linux. They also hope to contribute to linux,
then other embeded developers can share it.

On 1/11/07, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> Aubrey wrote:
> > On 1/11/07, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> >> What you _really_ want to do is avoid large mallocs after boot, or use
> >> a CPU with an mmu. I don't think nommu linux was ever intended to be a
> >> simple drop in replacement for a normal unix kernel.
> >
> >
> > Is there a position available working on mmu CPU? Joking, :)
> > Yes, some problems are serious on nommu linux. But I think we should
> > try to fix them not avoid them.
>
> Exactly, and the *real* fix is to modify userspace not to make > PAGE_SIZE
> mallocs[*] if it is to be nommu friendly. It is the kernel hacks to do things
> like limit cache size that are the bandaids.
>
> Of course, being an embedded system, if they work for you then that's
> really fine and you can obviously ship with them. But they don't need to
> go upstream.
>
> --
> SUSE Labs, Novell Inc.
> Send instant messages to your online friends http://au.messenger.yahoo.com
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
