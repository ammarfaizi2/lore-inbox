Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269954AbRHQInR>; Fri, 17 Aug 2001 04:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269944AbRHQInH>; Fri, 17 Aug 2001 04:43:07 -0400
Received: from ns.suse.de ([213.95.15.193]:34572 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S269954AbRHQImy>;
	Fri, 17 Aug 2001 04:42:54 -0400
To: linux-kernel@vger.kernel.org
Cc: ehaase@inf.fu-berlin.de
Subject: Re: ext2 not NULLing deleted files?
In-Reply-To: <01081709381000.08800@haneman.suse.lists.linux.kernel>
From: Andi Kleen <freitag@alancoxonachip.com>
Date: 17 Aug 2001 10:03:46 +0200
In-Reply-To: Enver Haase's message of "17 Aug 2001 09:42:44 +0200"
Message-ID: <oupitfnw1st.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Enver Haase <ehaase@inf.fu-berlin.de> writes:

> Hi there,
> 
> I just recognized there's an "undelete" now for ext2 file systems [a KDE 
> app].

There have been ext2 undeletes for many years now (and howtos how to do
it manually even longer), nothing new.

> 
> "The Other OS" in its professional version does of course clear the deleted 
> blocks with 0's for security reasons; I would have bet a thousand bucks Linux 
> would do so, too [seems I should have read the source code, good thing no-one 
> wanted to take on the bet :) ].
> 
> So how to go about this? With that feature wanted, which fs should one choose 
> under Linux? Is there a patch for ext2 for that feature? Am I the only one 
> liking the idea?

Old ext2 (before 2.0) supported this with a special attribute bit; but it was 
removed for good reasons.
Just NULLing alone is quite useless anyways; just 0ed data can be easily
recovered in a special laboratory by using old traces of magnetism on the
surfaces.
If you care about real data deletion you should probably use an utility
like wipe which does about 20-30 passes with random data. That is far too
complex to do in kernel space of course, but you can run it in user space
as needed. 0ing would just give you a false sense of security.

-Andi

