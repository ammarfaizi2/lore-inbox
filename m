Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262443AbUJ0PJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbUJ0PJm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 11:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbUJ0PJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 11:09:37 -0400
Received: from 66-61-159-17.dialroam.rr.com ([66.61.159.17]:52744 "EHLO
	nineveh.rivenstone.net") by vger.kernel.org with ESMTP
	id S262458AbUJ0PIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 11:08:10 -0400
Date: Wed, 27 Oct 2004 11:03:35 -0400
From: Joseph Fannin <jfannin1@columbus.rr.com>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Mathieu Segaud <matt@minas-morgul.org>,
       jfannin1@columbus.rr.com, agk@redhat.com, christophe@saout.de,
       linux-kernel@vger.kernel.org, bzolnier@gmail.com
Subject: Re: 2.6.9-mm1: LVM stopped working (dio-handle-eof.patch)
Message-ID: <20041027150333.GA2353@samarkand.rivenstone.net>
Mail-Followup-To: Jens Axboe <axboe@suse.de>,
	Andrew Morton <akpm@osdl.org>,
	Mathieu Segaud <matt@minas-morgul.org>, jfannin1@columbus.rr.com,
	agk@redhat.com, christophe@saout.de, linux-kernel@vger.kernel.org,
	bzolnier@gmail.com
References: <87oeitdogw.fsf@barad-dur.crans.org> <1098731002.14877.3.camel@leto.cs.pocnet.net> <20041026123651.GA2987@zion.rivenstone.net> <20041026135955.GA9937@agk.surrey.redhat.com> <20041026213703.GA6174@rivenstone.net> <20041026151559.041088f1.akpm@osdl.org> <87hdogvku7.fsf@barad-dur.crans.org> <20041026222650.596eddd8.akpm@osdl.org> <20041027054741.GB15910@suse.de> <20041027064146.GG15910@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041027064146.GG15910@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 08:41:46AM +0200, Jens Axboe wrote:
> On Wed, Oct 27 2004, Jens Axboe wrote:
> > On Tue, Oct 26 2004, Andrew Morton wrote:
> > > Mathieu Segaud <matt@minas-morgul.org> wrote:
> > > > Andrew Morton <akpm@osdl.org> disait derni?rement que :
> > > > 
> > > >  > If you have time, please restore dio-handle-eof.patch and then apply the
> > > >  > below fixup, then retest.  Thanks.
> > > > 
> > > >  I had time to test this fix; it did not solve the problem. Whereas reverting
> > > >  the complete dio-handle-eof.patch solved it.
> > > 
> > > bummer.  Can you send a super-simple means by which I can demonstrate the
> > > problem?
> > 
> > Hmm, maybe round the value up to a PAGE_SIZE in length?
> 
> This feels pretty icky, but should suffice for testing. Does it make a
> difference?

    I made this change to 2.6.9-mm1 and it didn't.  vgchange still
seems to be trying to read 2048 bytes, rather than 4096 (I may not
know what I'm talking about, or even what I'm looking at, though).

-- 
Joseph Fannin
jfannin1@columbus.rr.com

"Bull in pure form is rare; there is usually some contamination by data."
    -- William Graves Perry Jr.
