Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317670AbSGUOQi>; Sun, 21 Jul 2002 10:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317674AbSGUOQi>; Sun, 21 Jul 2002 10:16:38 -0400
Received: from mail.s3.kth.se ([130.237.48.5]:24584 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id <S317670AbSGUOQg>;
	Sun, 21 Jul 2002 10:16:36 -0400
To: Andrew Rodland <arodland@noln.com>
Cc: mru@users.sourceforge.net (M), linux-kernel@vger.kernel.org
Subject: Re: memory leak?
References: <yw1xn0sluqom.fsf@gladiusit.e.kth.se>
	<20020722100840.2599c2f3.arodland@noln.com>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 21 Jul 2002 16:19:35 +0200
In-Reply-To: Andrew Rodland's message of "Mon, 22 Jul 2002 10:08:40 -0400"
Message-ID: <yw1x1y9xups8.fsf@gladiusit.e.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Rodland <arodland@noln.com> writes:

> On 21 Jul 2002 16:00:09 +0200
> mru@users.sourceforge.net (M) wrote:
> 
> > 
> > I noticed that doing lots or file accesses causes the used memory to
> > increase, *after* subtracting buffers/cache. Here is an example:
> > 
> > $ free
> >              total       used       free     shared    buffers    
> >              cached
> > Mem:        773776      30024     743752          0       1992     
> > 10424-/+ buffers/cache:      17608     756168
> > Swap:        81904          0      81904
> > $ du > /dev/null
> > $ free
> >              total       used       free     shared    buffers    
> >              cached
> > Mem:        773776      78008     695768          0      26328     
> > 10472-/+ buffers/cache:      41208     732568
> > Swap:        81904          0      81904
> > 
> > Here 24 MB of memory have been used up. Repeating the du seems to have
> > little effect. This directory has ~3200 subdirs and 13400 files.
> > 
> > After a few hours use about 200 MB are used, apperently for
> > nothing. Killing all processed and unmounting file systems doesn't
> > help.
> > 
> > Is this a memory leak? I get the same results with ext2, ext3,
> > reiserfs and nfs.
> 
> wow!
> I've been seeing this, too, but I thought I was just reading something
> wrong. Especially after my nightly cron jobs (which involve a 'find
> /') run, I'll often find myself with 80% of physical RAM used, and
> nobody (as far as 'top' can see) using it. You didn't specify which
> kernel you're using, but I'm running 2.4.19-rc1-ac1 plus some patches,
> and I've seen it since at least about pre9-ac*. I might try to narrow it
> down more if it could be useful.

I forgot to mention the kernel version. It's 2.4.19-rc3. It's been
going on a while, though, before I took the time start looking for it.

-- 
Måns Rullgård
mru@users.sf.net
