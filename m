Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265527AbTF2Czm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 22:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265526AbTF2Czm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 22:55:42 -0400
Received: from franka.aracnet.com ([216.99.193.44]:24253 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S265618AbTF2CxO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 22:53:14 -0400
Date: Sat, 28 Jun 2003 20:07:06 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.73-mm2
Message-ID: <4160000.1056856024@[10.10.2.4]>
In-Reply-To: <20030629021809.GA26348@holomorphy.com>
References: <20030627202130.066c183b.akpm@digeo.com> <20030628155436.GY20413@holomorphy.com> <20030628170837.A10514@infradead.org> <56960000.1056846845@[10.10.2.4]> <20030629021809.GA26348@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--William Lee Irwin III <wli@holomorphy.com> wrote (on Saturday, June 28, 2003 19:18:09 -0700):

> On Sat, Jun 28, 2003 at 05:34:05PM -0700, Martin J. Bligh wrote:
>> Last time I measured it, it had about a 10% overhead in kernel time.
>> Seems like a good thing to keep as an option to me. Bill said he
>> had some other code to alleviate the overhead, but I don't think
>> it's merged ... I'd rather see UKVA (permanently map the pagetables
>> on a per-process basis) merged before it becomes "not an option" -
>> that gets rid of all the kmapping.
> 
> There are several orthogonal things going on here. One is dropping the
> hooks in the right places to get various concrete tasks done. Another
> is general resource scalability vs. raw overhead tradeoffs. The last
> one is gathering a wide enough repertoire of core hooks that arches can
> use "advanced" techniques like recursive pagetables when they require
> various kinds of intervention by the kernel to use.
> 
> This is just another set of hooks we'll need for our end goal, with a
> fully functional implementation. It has direct applications and is
> completely usable now for resource scalability albeit with some
> overhead. Things are all headed in the appropriate directions; the
> hooks do not conflict with and do not require any core modifications
> whatsoever in order to use in combination with recursive pagetables;
> they can simply recover information from already-available places and
> transparently replace the highpmd and highpte arch code.
> 
> I can work directly with Dave to arrange a proper demonstration of this
> (i.e. fully functional implementation) if need be. I've largely avoided
> interceding in recursive pagetable mechanics in order not to duplicate
> work.

Right, I'm not against what you're doing - I'm totally for it. My only
concern was that whilst it has some overhead, it should stay as a config
option (which you did). That lets people make the call of overhead vs
resource scaling.

Your patch is fine - just the talk of removing the config option scared 
me ;-)

M.


