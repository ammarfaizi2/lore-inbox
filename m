Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbUCIHYD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 02:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbUCIHYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 02:24:03 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:2716 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261518AbUCIHYA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 02:24:00 -0500
Message-ID: <404D7109.10902@cyberone.com.au>
Date: Tue, 09 Mar 2004 18:23:53 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Mike Fedyk <mfedyk@matchmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH 4/4] vm-mapped-x-active-lists
References: <404D56D8.2000008@cyberone.com.au> <404D5784.9080004@cyberone.com.au> <404D5A6F.4070300@matchmail.com> <404D5EED.80105@cyberone.com.au> <20040309070246.GI655@holomorphy.com>
In-Reply-To: <20040309070246.GI655@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



William Lee Irwin III wrote:

>On Tue, Mar 09, 2004 at 05:06:37PM +1100, Nick Piggin wrote:
>
>>Not sure to be honest, I haven't looked at it :\. I'm not really
>>sure if the rmap mitigation direction is just a holdover until
>>page clustering or intended as a permanent feature...
>>Either way, I trust its proponents will take the onus for regressions.
>>
>
>Actually, anobjrmap does wonderful things wrt. liberating pgcl
>internals from some very frustrating complications having to do with
>assumptions of a 1:1 correspondence between pte pages and struct pages,
>so I would regard work in the direction of anobjrmap as useful to
>advance the state of page clustering regardless of its rmap mitigation
>overtones.  The "partial" objrmap is actually insufficient to clean up
>this assumption, and introduces new failure modes I don't like (which
>it is in fact not necessary to do; aa's code is very close to doing the
>partial-but-insufficient-for-pgcl objrmap properly apart from trying to
>allocate more pte_chains than necessary and not falling back to the vma
>lists for linear/nonlinear mapping mixtures). The current port has some
>code to deal with this I'm extremely eager to dump as soon as things
>such as anobjrmap etc. make it possible, if they're merged.
>
>Current efforts are now a background/spare time affair centering around
>non-i386 architectures and driver audits.
>

OK. I had just noticed that the people complaining about rmap most
are the ones using 4K page size (x86-64 uses 4K, doesn't it?). Not
that this fact means it is OK to ignore them problem, but I thought
maybe pgcl might solve it in a more general way.

I wonder how much you gain with objrmap / anobjrmap on say a 64K page
architecture?

