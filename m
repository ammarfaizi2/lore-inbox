Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261678AbSJ2L3b>; Tue, 29 Oct 2002 06:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261729AbSJ2L3b>; Tue, 29 Oct 2002 06:29:31 -0500
Received: from ns.suse.de ([213.95.15.193]:40452 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261678AbSJ2L3a> convert rfc822-to-8bit;
	Tue, 29 Oct 2002 06:29:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Linux AG
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Subject: Re: [PATCH][RFC] 2.5.44 (1/2): Filesystem capabilities kernel patch
Date: Tue, 29 Oct 2002 12:35:51 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, Chris Evans <chris@scary.beasts.org>,
       Ulrich Drepper <drepper@redhat.com>,
       Pavel Machek <pavel@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.33.0210282327520.8990-100000@sphinx.mythic-beasts.com> <200210290323.09565.agruen@suse.de> <87n0oxmrhn.fsf@goat.bogus.local>
In-Reply-To: <87n0oxmrhn.fsf@goat.bogus.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210291235.51299.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 October 2002 12:09, Olaf Dietsche wrote:
> Andreas Gruenbacher <agruen@suse.de> writes:
> > A perhaps unrelated note: We once had Pavel Machek's elfcap
> > implementation, in which capabilities were stored in ELF. This was a bad
> > idea because being able to create executables does not imply the user is
> > capable of CAP_SETFCAP, and users shouldn't be able to freely choose
> > their capabilities :-] We still want
>
> I remember this hack and since I hear this claim every now and then, I
> downloaded his patch and verified with the source. Pavel's capability
> patch was about _restricting_ not granting capabilities, so it's more
> like an inheritable, rather than a permitted, set.
>
> At least that was his intention. I didn't verify this with the
> appropriate kernel sources from 1999.

I forgot to CC Pavel the last time. Elfcap probably truly was restrictive 
only. This is comparable to dropping capabilities very early in the suid root 
binaries themselves, and thus not a significant improvement.

We want to be able to also grant capabilities (not only restrict them), so we 
may have fewer suid root binaries.

--Andreas.

