Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318117AbSICPfB>; Tue, 3 Sep 2002 11:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318232AbSICPfA>; Tue, 3 Sep 2002 11:35:00 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:4 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S318117AbSICPe7>;
	Tue, 3 Sep 2002 11:34:59 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200209031539.g83FdVb02733@oboe.it.uc3m.es>
Subject: Re: [RFC] mount flag "direct" (fwd)
To: riel@conectiva.com.br
Date: Tue, 3 Sep 2002 17:39:31 +0200 (MET DST)
Cc: linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Thanks for the comment!

On Tue, 3 Sep 2002, Peter T. Breuer wrote:

> > Rationale:
> > No caching means that each kernel doesn't go off with its own idea of
> > what is on the disk in a file, at least. Dunno about directories and
> > metadata.

> And what if they both allocate the same disk block to another
> file, simultaneously ?

I see - yes, that's a good one.

I assumed that I would need to make several VFS operations atomic
or revertable, or simply forbid things like new file allocations or
extensions (i.e.  the above), depending on what is possible or not.

This is precisely the kind of objection that I want to hear about.

OK - reply:
It appears that in order to allocate away free space, one must first
"grab" that free space using a shared lock. That's perfectly feasible.

Thank you.

Where could I intercept the block allocation in VFS?

> A mount option isn't enough to achieve your goal.
> 
> It looks like you want GFS or OCFS. Info about GFS can be found at:

No, I don't want ANY FS. Thanks, I know about these, but they're not
it. I want support for /any/ FS at all at the VFS level.

>	http://www.opengfs.org/
>	http://www.sistina.com/  (commercial GFS)

> Dunno where Oracle's cluster fs is documented.

I know about that too, but no, I do not want ANY FS, I want /any/ FS.
:-)

Peter
