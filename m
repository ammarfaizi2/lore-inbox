Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312616AbSDFRZy>; Sat, 6 Apr 2002 12:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312619AbSDFRZx>; Sat, 6 Apr 2002 12:25:53 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:23032 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S312616AbSDFRZw>; Sat, 6 Apr 2002 12:25:52 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020406090540.B12017@work.bitmover.com> 
To: Larry McVoy <lm@bitmover.com>
Cc: Dave Jones <davej@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.8-pre1 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 06 Apr 2002 18:25:47 +0100
Message-ID: <24920.1018113947@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


lm@bitmover.com said:
>  If you want to do it preserving all the BK info, i.e., a pull with
> some option to send a particular changeset, that doesn't work.  BK has
> an  invariant which is that the parent of any changeset you send must
> be present in the receiving repository or it won't work.

> What you want to do is cherrypick, to do that with BK you have two
> choices:
>    a) wait for LODs
>    b) export as a patch and import as a patch.

c) Observe that all the files touched are identical in the two repositories
	before the changeset in question.
   Copy the post-changeset SCCS files for the changed files to the new 
	repository.
   Get the relevant lines identifying each new delta from the ChangeSet file
	in the original repository, add them to the ChangeSet file in the
	new repository, and bk ci it.
   Mutter darkly that this really shouldn't be hard to get BK to do by
	itself, in the case where the pre-changeset files are identical in
	each repository.

Admittedly I hadn't created any files that time, just committed a large
patch by copying in the new version of many files (from a CVS tree), running
bk citool and giving an appropriate change log for each one - hence I didn't
want to lose the change logs by exporting and reimporting it when I
realised I'd actually done it in the wrong repository.

--
dwmw2


