Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbVAFXkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVAFXkx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 18:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263124AbVAFXkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 18:40:13 -0500
Received: from holomorphy.com ([207.189.100.168]:14785 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263101AbVAFXfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 18:35:39 -0500
Date: Thu, 6 Jan 2005 15:35:19 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Ray Bryant <raybry@sgi.com>
Cc: Christoph Lameter <clameter@sgi.com>, Andi Kleen <ak@muc.de>,
       Hugh Dickins <hugh@veritas.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>,
       Marcello Tosatti <marcelo.tosatti@cyclades.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: page migration patchset
Message-ID: <20050106233519.GD9636@holomorphy.com>
References: <Pine.LNX.4.44.0501052008160.8705-100000@localhost.localdomain> <41DC7EAD.8010407@mvista.com> <20050106144307.GB59451@muc.de> <20050106223046.GB9636@holomorphy.com> <41DDC7F2.2020909@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41DDC7F2.2020909@sgi.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 03:43:07PM +0100, Andi Kleen wrote:
>>> If nothing happens soon regarding the "other" hugetlb code I will
>>> forward port my SLES9 code. It already has NUMA policy support.
>>> For now you can remove the hugetlb policy code from mainline if you

William Lee Irwin III wrote:
>> This is not specifically directed at Andi...

On Thu, Jan 06, 2005 at 05:21:22PM -0600, Ray Bryant wrote:
> Who is it directed at then?
> And who does "you" refer to here?

The set of people who have contributed hugetlb patches, plus akpm.


William Lee Irwin III wrote:
>> Obviously, I have no recourse, otherwise there would be no credible
>> threat of this kind of end-run tactic succeeding, and I've apparently
>> already been circumvented by pushing the things to distros anyway. So
>> I can do no more than kindly ask you to address issues 1-6 in your
>> patch presentations.

On Thu, Jan 06, 2005 at 05:21:22PM -0600, Ray Bryant wrote:
> I'd point out that one of the reasons we have Christoph Lameter working
> on this is that he is better at working with cross architecture type
> stuff than I am, since I have neither the skills nor interest to do
> such things (I'm much too focused on Altix specific problems).

Not all points apply to all patches, of course. I've seen the
separation of functions problems more in Christoph's patches than
portability issues, not to say they are nonexistant. The most prominent
case of a portability issue was in Kenneth Chen's patches.


On Thu, Jan 06, 2005 at 05:21:22PM -0600, Ray Bryant wrote:
> So, I guess the question is, do you, wli, have allocate hugetlbpage on
> fault code available somewhere that we, SGI, have somehow stepped on,
> ignored, or not properly given credit for?  SGI has a strong requirement
> to  eliminate the current "allocate hugetlb pages at mmap() time",
> single-threaded allocation.  (We have sold machines where it would
> take thousands of seconds to complete that operation as it is
> currently coded in the mainline.)

That bit was largely directed at akpm, regarding an off-list discussion.


On Thu, Jan 06, 2005 at 05:21:22PM -0600, Ray Bryant wrote:
> We need the allocate on fault hugetlbpage code.  We worked quite hard
> to get that code to behave the same way wrt out of memory failures as the
> existing code.  To say that we didn't worry about backwards
> compatibility there (at least in that regard) is simply absurd.
> But I care not where this code comes from.  If it works, meets our
> scaling requirements, and can get accepted into the mainline, then
> I am all for it.  And I will happily give credit where credit is
> due.

The backward compatibility concerns apply to a past patch, the
expand-on-mmap() code, and the COW patches. Zero-fill-on-demand patches
haven't posed particular problems there.


On Thu, Jan 06, 2005 at 05:21:22PM -0600, Ray Bryant wrote:
> However, at the pesent time it appears that if we want this code in the
> mainline, we will have to bring it up to level and push it upstream,
> and that is what Christoph is working on.
> When that happens, the code is subject to review and we look forward
> to working with you to resolve your concerns (1)-(6) wrt to those
> patches.

My hurt feelings about my own code won't have an impact on this.

What has been holding up the show has been a serious bug there has not
been a resolution on yet. I'm probably going to give up on that bug
being fixed before other things are done and just do the heavy review
and testing, particularly as I'm in a unique position to have access to
all of the arches supporting hugetlb.


-- wli
