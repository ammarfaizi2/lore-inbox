Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261881AbRE2ViT>; Tue, 29 May 2001 17:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262052AbRE2ViJ>; Tue, 29 May 2001 17:38:09 -0400
Received: from cx595243-c.okc1.ok.home.com ([24.6.27.53]:16512 "EHLO
	quark.localdomain") by vger.kernel.org with ESMTP
	id <S261881AbRE2Vhw>; Tue, 29 May 2001 17:37:52 -0400
From: Vincent Stemen <linuxkernel@AdvancedResearch.org>
Date: Tue, 29 May 2001 16:36:37 -0500
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
Cc: linux-kernel@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linuxkernel@AdvancedResearch.org (Vincent Stemen)
In-Reply-To: <E154pvH-0004q1-00@the-village.bc.nu>
In-Reply-To: <E154pvH-0004q1-00@the-village.bc.nu>
Subject: Re: Plain 2.4.5 VM... (and 2.4.5-ac3)
MIME-Version: 1.0
Message-Id: <01052916363700.00493@quark>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 May 2001 15:16, Alan Cox wrote:
> > a reasonably stable release until 2.2.12.  I do not understand why
> > code with such serious reproducible problems is being introduced into
> > the even numbered kernels.  What happened to the plan to use only the
>
> Who said it was introduced ?? It was more 'lurking' than introduced. And
> unfortunately nobody really pinned it down in 2.4test.
>

I fail to see the distinction.  First of all, why was it ever released
as 2.4-test?  That question should probably be directed at Linus.  If
it is not fully tested, then it should be released it as an odd
number.  If it already existed in the odd numbered development kernel
and was known, then it should have never been released as a production
kernel until it was resolved.  Otherwise, it completely defeats the
purpose of having the even/odd numbering system.

I do not expect bugs to never slip through to production kernels, but
known bugs that are not trivial should not, and serious bugs like
these VM problems especially should not.


> > By the way,  The 2.4.5-ac3 kernel still fills swap and runs out of
> > memory during my morning NFS incremental backup.  I got this message
> > in the syslog.
>
> 2.4.5-ac doesn't do some of the write throttling. Thats one thing I'm
> still working out. Linus 2.4.5 does write throttling but Im not convinced
> its done the right way
>
> > completely full.  By that time the memory was in a reasonable state
> > but the swap space is still never being released.
>
> It wont be, its copied of memory already in apps. Linus said 2.4.0 would
> need more swap than ram when he put out 2.4.0.
>

I do not like that at all.  I should not have to have to tie up a
bunch of extra hard drive space for swap if I have plenty of RAM for
90% of my usage.  During the 2.0.x days I was always able to run with
a small swap or no swap at all when I had 80-128Mb RAM and it was
always rock solid.  It seems to me that the swap space should just add
to your virtual memory and the size ratio between swap and RAM should
not matter.

- Vincent Stemen
