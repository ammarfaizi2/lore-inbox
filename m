Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270784AbUJUPk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270784AbUJUPk7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 11:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270777AbUJUPf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 11:35:57 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:41399 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S270718AbUJUPeJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 11:34:09 -0400
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Versioning of tree
References: <1098254970.3223.6.camel@gaston>
	<1098256951.26595.4296.camel@d845pe>
	<Pine.LNX.4.58.0410200728040.2317@ppc970.osdl.org>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@mru.ath.cx>
Date: Thu, 21 Oct 2004 17:33:53 +0200
In-Reply-To: <Pine.LNX.4.58.0410200728040.2317@ppc970.osdl.org> (Linus
 Torvalds's message of "Wed, 20 Oct 2004 07:33:47 -0700 (PDT)")
Message-ID: <yw1xd5zculum.fsf@mru.ath.cx>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Wed, 20 Oct 2004, Len Brown wrote:
>>
>> On Wed, 2004-10-20 at 02:49, Benjamin Herrenschmidt wrote:
>> > 
>> > After you tag a "release" tree in bk, could you bump the version
>> > number right away, with eventually some junk in EXTRAVERSION like
>> > "-devel" ?
>> 
>> I'd find this to be really helpful too.  There has been this period
>> between, say, 2.6.9 and 2.6.10-whatever where my build/install scripts
>> scribble over my "reference" kernels.
>
> Personally, I much rather go the way we have gone, because I don't care
> about module versioning nearly as much as I care about bug-report
> versioning. And if I hear about a bug with 2.6.10-rc1, I want to know that
> it really is at _least_ 2.6.10-rc1, if you see what I mean..
>
> Now, personally, I'd actually like to know the exact top-of-tree
> changeset, so I've considered having something that saves that one away,
> but then we'd need to do something about non-BK users (make the nightly 
> snapshots squirrell it away somewhere too). That would solve both the 
> module versioning _and_ the bug-report issue.
>
> So if somebody comes up with a build script that generates that kind of 
> extra-version automatically, I'm more receptive. But I don't want to muck 
> with the version manually in a way that I think is the wrong way around..

Would it work to somewhere in the Makefile check for the existence of
a BitKeeper directory, and if it exists run bk with the appropriate
arguments and append something to EXTRAVERSION?  I'm not quite sure
which information is the best to add, though.

-- 
Måns Rullgård
mru@mru.ath.cx
