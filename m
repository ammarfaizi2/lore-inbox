Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261421AbULATlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbULATlm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 14:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbULATlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 14:41:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:23477 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261421AbULATlj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 14:41:39 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       David Woodhouse <dwmw2@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
References: <19865.1101395592@redhat.com>
	<20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
	<1101406661.8191.9390.camel@hades.cambridge.redhat.com>
	<20041127032403.GB10536@kroah.com>
	<16810.24893.747522.656073@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
	<ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br>
	<Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org>
	<oract0thnj.fsf@livre.redhat.lsd.ic.unicamp.br>
	<Pine.LNX.4.58.0411291458040.22796@ppc970.osdl.org>
	<oris7nrq0h.fsf@livre.redhat.lsd.ic.unicamp.br>
	<Pine.LNX.4.58.0411301413260.22796@ppc970.osdl.org>
	<or4qj7rllv.fsf@livre.redhat.lsd.ic.unicamp.br>
	<Pine.LNX.4.58.0411301505580.22796@ppc970.osdl.org>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 01 Dec 2004 17:41:25 -0200
In-Reply-To: <Pine.LNX.4.58.0411301505580.22796@ppc970.osdl.org>
Message-ID: <orvfbllsbe.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 30, 2004, Linus Torvalds <torvalds@osdl.org> wrote:

> On Tue, 30 Nov 2004, Alexandre Oliva wrote:

>> On Nov 30, 2004, Linus Torvalds <torvalds@osdl.org> wrote:

>> > If you want to use a legal analogy, the ABI is not a contract, it's a
>> > public _license_.

>> I didn't mean to use a legal analogy.  I meant contract in the
>> software engineering sense.  Sorry if that wasn't clear.

> Then your definition of a "contract" is flawed or your world-view has 
> nothing to do with reality.

It's not my definition, it's a definition used in software
engineering.  Sure, if you ask a legal mind, you'll get a different
answer.  If you ask a bridge player, you'll get yet another
definition.  That's why we have jargons in which common-use words have
their meanings narrowed to the specifics of certain fields.  And
that's why it's so hard for specialists in different fields to talk to
each other at times when there's disagreement about the precise
meaning of certain words.

> An ABI is not a contract.

Not a legal contract, for sure.

An ABI is a definition of an interface, including operations with pre-
and post-conditions, data structures with their invariants, constants,
file formats, etc.  Most of that is covered by the software
engineering term `contract'.

Sure enough, the headers we're talking about describe only a very
small portion on that; pretty much only data structures and
constants.  It certainly doesn't *specify* the entire ABI, it only
highlights portions of it.



Anyhow, all of this is beyond the point.  I see you've decreed that
people can introduce `user' directories in the kernel now.  Would you
please reconsider and choose a dir name that would enable the same ABI
headers to be used by kernel and userland, without adding a directory
to /usr/include that has no indication that it comes from the kernel?

Thanks,

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
