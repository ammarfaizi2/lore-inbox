Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbWEBNeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbWEBNeW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 09:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbWEBNeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 09:34:22 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:9696 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964812AbWEBNeV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 09:34:21 -0400
Date: Tue, 2 May 2006 14:34:16 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Avi Kivity <avi@argo.co.il>
Cc: Willy Tarreau <willy@w.ods.org>, David Schwartz <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: Compiling C++ modules
Message-ID: <20060502133416.GT27946@ftp.linux.org.uk>
References: <161717d50605011046p4bd51bbp760a46da4f1e3379@mail.gmail.com> <MDEHLPKNGKAHNMBLJOLKEEGCLKAB.davids@webmaster.com> <20060502051238.GB11191@w.ods.org> <44573525.7040507@argo.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44573525.7040507@argo.co.il>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2006 at 01:32:05PM +0300, Avi Kivity wrote:
> Like the recent prevent_tail_call() thing? Granted, C++ is a lot tricker 
> than C. Much self-restraint is needed, and even then you can wind up 
> where you didn't want to go.

	Sigh...  You know, once upon a time there was a language called
Algol 68.  It had a _lot_ of expressive power and was fairly flexible -
both in type system and in syntax.  And it had been a fscking nightmare
for large projects.  Not because of lack of modularity - that part had
been all right.  The thing that kept killing large projects was different;
in effect, each group ended up with a language subset and developed a
discipline for it.  And as soon as they mixed, _especially_ if they were
close, but not quite the same, you had an ever-growing disaster.

	It's not easy to quantify; each language has dark corners and
there are more or less odd constructs specific to individual programmers
and to groups.  And yes, you certainly can write unreadable crap in any
language.  The question is, how many variants of "needed self-restraint"
are widespread, how well do they mix and how easy it is to recognize the
mismatches?  It's not a function of language per se, so it doesn't make
sense to compare C and C++ as languages in that respect.  However, C++
and C _styles_ can be compared and that's where C++ requires more force
to keep a large project away from becoming a clusterfsck.

	Sure, you need make sure that different groups of people use
more or less compatible styles anyway; it's just that with C++ you need
tighter control to get the same result.  And for kernel it's a killer.
