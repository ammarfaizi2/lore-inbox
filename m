Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268234AbUIKRrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268234AbUIKRrA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 13:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268239AbUIKRrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 13:47:00 -0400
Received: from open.hands.com ([195.224.53.39]:14493 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S268234AbUIKRqM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 13:46:12 -0400
Date: Sat, 11 Sep 2004 18:57:26 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Patrick McHardy <kaber@trash.net>
Cc: linux-kernel@vger.kernel.org,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: [PATCH 2.6 NETFILTER] new netfilter module ipt_program.c
Message-ID: <20040911175726.GD12835@lkcl.net>
References: <20040911124106.GD24787@lkcl.net> <4142F4CC.7080708@trash.net> <20040911132935.GF24787@lkcl.net> <20040911133443.GG24787@lkcl.net> <41430D5E.9030207@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41430D5E.9030207@trash.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2004 at 04:36:14PM +0200, Patrick McHardy wrote:
> Luke Kenneth Casson Leighton wrote:
> >On Sat, Sep 11, 2004 at 02:29:35PM +0100, Luke Kenneth Casson Leighton 
> >wrote:
> >
> > thing is, you see, i know just enough to be dangerous.
> >
> > using files->file_lock a) seems to work b) is accepted code in the
> > kernel.
> 
> It seems to work - on UP where it is a NOP. On SMP it will deadlock.
> That we have some broken code doesn't mean we want more of it :)
 
 *cackle*

> > if someone else has the experience and knowledge to fix ipt_owner.c
> > i'll quite happily cut/paste that instead - once it's fixed.
> 
> The "fix" is quite easy, replace all occurences of
> spin_lock(&files->file_lock) in the kernel by spin_lock_bh.
 
> But that's not going to be accepted. 

 's'just'a'big'job'for "replace", innit?

 [btw _what_ is the "replace" command doing in the debian mysql package??]

> IIRC the SELinux guys
> want to label packets with the name of the sending process,
> maybe we can use this for the owner match once it's done.

 ... well, given that i'll be rolling this out (broken or not)
 on a single-processor SELinux system, whatever is added
 [for selinux] would also need to be useable by thingy.
 ipt_owner.c.  as well.

 l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />

