Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289639AbSBSE6A>; Mon, 18 Feb 2002 23:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289733AbSBSE5v>; Mon, 18 Feb 2002 23:57:51 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46928 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S289639AbSBSE5i>; Mon, 18 Feb 2002 23:57:38 -0500
To: Andrew Morton <akpm@zip.com.au>
Cc: john <john@zlilo.com>, linux-kernel@vger.kernel.org
Subject: Re: kupdated using all CPU
In-Reply-To: <20020218134041.A2586@doom.sfo.covalent.net>
	<3C717C72.72A994D3@zip.com.au> <3C717C72.72A994D3@zip.com.au>
	<20020218141920.D2586@doom.sfo.covalent.net>
	<3C71848A.3DA9BC42@zip.com.au>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 18 Feb 2002 21:53:08 -0700
In-Reply-To: <3C71848A.3DA9BC42@zip.com.au>
Message-ID: <m18z9q3wej.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@zip.com.au> writes:

> john wrote:
> > 
> > [Mon, Feb 18, 2002 at 02:13:06PM -0800] akpm@zip.com.au wrote:
> > + john wrote:
> > + >
> > + > hi,
> > + > ive searched all over and found many references to this problem, but
> > + > never found an actual solution.  the problem is that during heavy
> > + > disk I/O, kupdated will periodically take up ALL the cpu.
> > +
> > + I've seen a couple of reports of this, nothing to indicate that it's
> > + a common problem?
> > +
> > + In the other reports, it was related to extremely low disk throughput.
> > + What does `hdparm -t /dev/hda' say?
> > 
> > root@doom:~# hdparm -t /dev/hda
> > 
> > /dev/hda:
> >  Timing buffered disk reads:  64 MB in 25.60 seconds =  2.50 MB/sec
> 
> ugh.  OK, I'll see if I cen reproduce this - there's no reason
> why disk suckiness should cause high CPU load.  But you need to
> pay some attention to your IDE settings in kernel config, and
> possibly tuning.


Another possibility with the same symptoms is that there are simply
very large I/O request starving everything else out.  When some
crucial data needs to be paged back in.  john can you confirm you
looked in top and saw kupdate taking 100% of the cpu?

Eric
