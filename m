Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268577AbUHaN5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268577AbUHaN5j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 09:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268582AbUHaN5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 09:57:39 -0400
Received: from nevyn.them.org ([66.93.172.17]:51153 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S268577AbUHaN5Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 09:57:24 -0400
Date: Tue, 31 Aug 2004 09:56:54 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Linus Torvalds <torvalds@osdl.org>, Roland McGrath <roland@redhat.com>,
       Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cleanup ptrace stops and remove notify_parent
Message-ID: <20040831135654.GA22337@nevyn.them.org>
Mail-Followup-To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Linus Torvalds <torvalds@osdl.org>,
	Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200408310411.i7V4B8Vs027772@magilla.sf.frob.com> <Pine.LNX.4.58.0408302119110.2295@ppc970.osdl.org> <87k6vfqwc7.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k6vfqwc7.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 10:19:04PM +0900, OGAWA Hirofumi wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > Ok, I definitely agree with the approach
> 
> I agree with that approach.
> 
> > Looks pretty clean as an implementation. The question is whether we should 
> > aim for 2.6.9 or 2.6.10 - if the first, then I should probably take it 
> > now, otherwise it should go into -mm first and be merged early after 2.6.9 
> > has been released, for the first -rc.
> > 
> > I _looks_ pretty safe, and it's hopefully much less likely to have subtle
> > bugs and races than our old approach had, but I have a hard time judging. 
> 
> Ptrace has several ugly things. And I'm thinking those needs
> user-visible change more or less to improve, like this.
> (->parent/wait4/child_list, PTRACE_SYSCALL/PTRACE_SINGLESTEP ...)
> 
> Should we also clean up and improve those with user-visible change?
> Those should be thought as separate issue?
> 
> I think we should be improved with new interface... (after it, we
> can deprecate ptrace)

I recommend the same thing I recommend every time this comes up: make
sure to take a look at how Solaris does this through /proc.  It seems
to be much nicer.

-- 
Daniel Jacobowitz
