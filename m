Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274832AbRJJFeE>; Wed, 10 Oct 2001 01:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274842AbRJJFdw>; Wed, 10 Oct 2001 01:33:52 -0400
Received: from barry.mail.mindspring.net ([207.69.200.25]:43825 "EHLO
	barry.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S274832AbRJJFdg>; Wed, 10 Oct 2001 01:33:36 -0400
Subject: Re: Compile Filure on 2.4.10-ac10+preempt+smp
From: Robert Love <rml@tech9.net>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011009222403.A12825@mikef-linux.matchmail.com>
In-Reply-To: <20011009214655.A26663@mikef-linux.matchmail.com>
	<1002690949.862.233.camel@phantasy> 
	<20011009222403.A12825@mikef-linux.matchmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15.99+cvs.2001.10.05.08.08 (Preview Release)
Date: 10 Oct 2001 01:34:41 -0400
Message-Id: <1002692093.1243.238.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-10-10 at 01:24, Mike Fedyk wrote:
> On Wed, Oct 10, 2001 at 01:15:25AM -0400, Robert Love wrote:
> >
> > Ahh, yes.  Thank you for spotting this.  include/asm-i386/spinlock.h has
> > two separate defines for spin_unlock and we only renamed one of them.  I
> > guess you hit the conditional that used the other define...
> >
> > The attached patch fixes it.
> >
> 
> Thank you.  Will compile now...

Let me know, I didn't test :)

If it works I will merge it...

> > I only keep around patches to the last official kernel, plus the latest
> > -pre and -ac I patched.  Since the patch itself is being updated, its a
> > pain to backport to older kernels.
> >
> 
> No, I'm not asking for backport, just links to one version back just in case
> the latest patch has a bug much like this...
> 
> I'd rather run one (working) version back than have to go to UP just to get
> preempt...  Needless to say, I chose to keep smp.

OK, then try editing the URL, I scp the patches in and don't ssh in and
actually clean the stuff up but every here and there.

ie, change the ac10 to ac9 in the URL.

The ChangeLog should tell you when a change occured that broke
something.  This changed happened during 2.4.10-ac5 (unless some later
-ac added the second spin_unlock define).

