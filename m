Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbWATVVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWATVVZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 16:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbWATVVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 16:21:25 -0500
Received: from free.wgops.com ([69.51.116.66]:10254 "EHLO shell.wgops.com")
	by vger.kernel.org with ESMTP id S932209AbWATVVY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 16:21:24 -0500
Date: Fri, 20 Jan 2006 14:21:06 -0700
From: Michael Loftis <mloftis@wgops.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Valdis.Kletnieks@vt.edu, dtor_core@ameritech.net,
       James Courtier-Dutton <James@superbug.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
Message-ID: <5793EB6F192350088E0AC4CE@d216-220-25-20.dynip.modwest.com>
In-Reply-To: <20060120200051.GA12610@flint.arm.linux.org.uk>
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com>
 <43D10FF8.8090805@superbug.co.uk>
 <6769FDC09295B7E6078A5089@d216-220-25-20.dynip.modwest.com>
 <d120d5000601200850w611e8af8v41a0786b7dc973d9@mail.gmail.com>
 <30D11C032F1FC0FE9CA1CDFD@d216-220-25-20.dynip.modwest.com>
 <200601201903.k0KJ3qI7006425@turing-police.cc.vt.edu>
 <E27F809F04C1C673D283E84F@d216-220-25-20.dynip.modwest.com>
 <20060120200051.GA12610@flint.arm.linux.org.uk>
X-Mailer: Mulberry/4.0.4 (Mac OS X)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-MailScanner-Information: Please contact support@wgops.com
X-MailScanner: WGOPS clean
X-MailScanner-From: mloftis@wgops.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On January 20, 2006 8:00:52 PM +0000 Russell King 
<rmk+lkml@arm.linux.org.uk> wrote:

> On Fri, Jan 20, 2006 at 12:21:40PM -0700, Michael Loftis wrote:
>> I think that it's fine to push the maintenance effort away from the
>> mainline developers, probably even desireable, but then the
>> bugfixing/etc  tends to happen in a disparate manner, off on lots of
>> forks at different  places without them making their way back to some
>> central place.
>
> The responsibility for ensuring that those bugfixes get back to "some
> central place" is with the folk who created the bugfixes.
>
> I've seen this _far_ too many times - it's what I call "the CVS disease"
> and it happens _a_ _lot_ in certain areas.
>
> Developer X uses a CVS tree for his work and has write access to that
> tree.  He finds a bug, and fixes it.  Maybe he writes a good explaination
> of the bug and puts it in the CVS commit comments.  He commits the fix.
> When he's done with development, he walks away and the fix never gets
> submitted.  (Not everyone operates this way, but I know some do.)
>
>
> As a mainline guy myself, I'll say we're all welcome to whatever bug
> fixes come our way.  We just need someone to send them to us with an
> adequate explaination of the bug.

OK, my question though related to that is, where would they be included? 
For most of my cases, latest development doesn't really help.  I'd still 
have to maintain a completely forked kernel.  Would they be included or 
eligible for the 4th digit releases you're talking about?  But then that 
seems that efforts might get really spread out across the many 3rd digit 
releases, making that situation just as bad, or worse, as the previous 
odd/even issues.

>
>> And that seems where we're going with this conversation.  A fork/forks
>> at  various versions to maintain bugfixes and support updates that's
>> (more?)  open to submitters writing patches.  Maintained by a separate
>> group or  party, but with the 'blessing' from mainline to do so.  A
>> place for those  sorts of efforts to be focused, without necessarily
>> involving the primary  developers.
>
> Do you know about the bugfix-only kernel series, which have 4-digit
> versions - 2.6.x.y - which is the compromise to satisfy folk with the
> issue you're bringing up in this paragraph?

I don't see any maintenance releases on 2.6.8 edxcept one which addresses a 
separate issue I ran into I don't see an updated e1000 in 2.6.8 (I'm not 
sure where exactly this particlar e1000 gets supported Manuf ID is intel, 
0x0108 is the device id...IIRC) but I'm pretty sure it's supported in 
2.6.15, can't go much earlier than that because 2.6.9 and later seem to 
have bugs with aic7xxx up until 2.6.14 or 15 (not clear here, I haven't 
done enough testing, so basing that on input from others) as mentioned 
though 2.6.8 also has buglets.  I think 2.6.8.1 actually has a fix for the 
NFS problem I forgot about in my slightly earlier reply to a separate part 
of this thread, though I don't know if Debian has included that in their 
2.6.8 kernels or not.  Not even totally sure that's the issue I was seeing, 
I'm still investigating that too.

I think the four digit bugfix only stuff is an excellent step, and 
necessary.  But the thing that I need more is stable APIs (both userland 
and kernel, and at the kernel<->userland interface) *with* bugfixes and 
(hopefully with) trivial hardware support update backports, like the 
replacement e1000 driver.  And I guess I shouldn't say 'I' need, but 
colleagues need.  And it's not just one company or one project or one 
client/customer.  And not all the issues are the same, but they come back 
to needing somewhere that's kept 'dusted off' but not rearranged (too?) 
regularly.


