Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbVJFQJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbVJFQJw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 12:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbVJFQJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 12:09:52 -0400
Received: from qproxy.gmail.com ([72.14.204.200]:3639 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751111AbVJFQJv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 12:09:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rfJlxZJm3h6z2RKyQ676BtKp1dHIrAATQ4XcoG7B8qUaFuwozC5S4lPHmSFue9vrVr3+FfDbsccboUTp1UIMUJKYTB1v6Je+fmHzdyRx+AerVfCUgTFuUu4TTk+yk6PMZg5kjlCl7FUYLdGVp215dZbT4ClcH3poWwYvw9R3ksA=
Message-ID: <9a8748490510060909v33c0a30eobf0cd0b7f1886122@mail.gmail.com>
Date: Thu, 6 Oct 2005 18:09:50 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: [PATCH] Documentation: ksymoops should no longer be used to decode Oops messages
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <di3h5d$f82$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200510052239.43492.jesper.juhl@gmail.com>
	 <di3h5d$f82$1@sea.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/05, Kalin KOZHUHAROV <kalin@thinrope.net> wrote:
> Jesper Juhl wrote:
> > Document the fact that ksymoops should no longer be used to decode Oops
> > messages.
> >
[snip]
>
> OK, but what should I use then with 2.6??

Nothing at all.
Just post the raw Oops message as-is (from console or dmesg).

> And since when is ksymoops not usable with it?

At least since 2003 and the 2.5 kernel series.
The oldest reference I could find in the archives is an email by Dave
Jones dating back to Mon Apr 14 2003 - 14:31:44 EST
http://www.uwsg.iu.edu/hypermail/linux/kernel/0304.1/1533.html

The interresting part of that mail is this bit

"Merging of kksymoops means that the kernel will now spit out
 automatically decoded oopses (no more feeding them to ksymoops).
 For this reason, you should always enable the option in the
 kernel hacking menu labelled "Load all symbols for debugging/kksymoops".
"

> I have reported quite a few times here, alaways with 2.6.x and nobody said anything about it...

They should have.

Please read a recent Documentation/oops-tracing.txt (here's a link:
http://sosdg.org/~coywolf/lxr/source/Documentation/oops-tracing.txt?v=2.6.14-rc2
)

See the note at the top :

"NOTE: ksymoops is useless on 2.6.  Please use the Oops in its original format
 (from dmesg, etc).  Ignore any references in this or other docs to "decoding
 the Oops" or "running it through ksymoops".  If you post an Oops fron 2.6 that
 has been run through ksymoops, people will just tell you to repost it.
"


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
