Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261512AbVAMFEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbVAMFEv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 00:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbVAMFEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 00:04:51 -0500
Received: from holomorphy.com ([207.189.100.168]:20201 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261512AbVAMFEs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 00:04:48 -0500
Date: Wed, 12 Jan 2005 20:49:42 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Jones <davej@redhat.com>, torvalds@osdl.org,
       marcelo.tosatti@cyclades.com, greg@kroah.com, chrisw@osdl.org,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: thoughts on kernel security issues
Message-ID: <20050113044942.GI14443@holomorphy.com>
References: <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <20050112185133.GA10687@kroah.com> <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112161227.GF32024@logos.cnet> <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112205350.GM24518@redhat.com> <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org> <20050112182838.2aa7eec2.akpm@osdl.org> <20050113033542.GC1212@redhat.com> <20050112194239.0a7b720b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050112194239.0a7b720b.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>> The problem is it depends on who you are, and what you're doing with Linux
>> how much these things affect you.
>> A local DoS doesn't both me one squat personally, as I'm the only
>> user of computers I use each day. An admin of a shell server or
>> the like however would likely see this in a different light.
>> (though it can be argued a mallet to the kneecaps of the user
>>  responsible is more effective than any software update)

On Wed, Jan 12, 2005 at 07:42:39PM -0800, Andrew Morton wrote:
> yup.  But there are so many ways to cripple a Linux box once you have local
> access.  Another means which happens to be bug-induced doesn't seem
> important.

This is too broad and sweeping of a statement, and can be used to
excuse almost any bug triggerable only by local execution.

Most of the local DoS's I'm aware of are memory management -related,
i.e. user- triggerable proliferation of pinned kernel data structures.
Beancounter patches were meant to address at least part of that. Paging
the larger kernel data structures users can trigger proliferation of
would also be a large help.


Dave Jones <davej@redhat.com> wrote:
>> An information leak from kernel space may be equally as mundane to some,
>> though terrifying to some admins. Would you want some process to be
>> leaking your root password, credit card #, etc to some other users process ?
>> priveledge escalation is clearly the number one threat. Whilst some
>> class 'remote root hole' higher risk than 'local root hole', far
>> too often, we've had instances where execution of shellcode by
>> overflowing some buffer in $crappyapp has led to a shell
>> turning a local root into a remote root.

On Wed, Jan 12, 2005 at 07:42:39PM -0800, Andrew Morton wrote:
> I'd place information leaks and privilege escalations into their own class,
> way above "yet another local DoS".
> A local privilege escalation hole should be viewed as seriously as a remote
> privilege escalation hole, given the bugginess of userspace servers, yes?

I agree on the latter count. On the first, I have to dissent with the
assessment of local DoS's as "unimportant".


-- wli
