Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317096AbSGCUQP>; Wed, 3 Jul 2002 16:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317059AbSGCUQO>; Wed, 3 Jul 2002 16:16:14 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:56469 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S317006AbSGCUQN>; Wed, 3 Jul 2002 16:16:13 -0400
Date: Wed, 3 Jul 2002 16:18:44 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200207032018.g63KIis03950@devserv.devel.redhat.com>
To: Eduard Bloch <edi@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.22] simple ide-tape.c and ide-floppy.c cleanup
In-Reply-To: <mailman.1025711581.26152.linux-kernel2news@redhat.com>
References: <mailman.1025711581.26152.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>[...]
> To be honest - why keep ide-[cd,floppy,tape] when they can be almost
> completely replaced with ide-scsi?

James Bottomley was going to take care of this, so I did not
even bother with ide-tape cleanups in 2.5. Good riddance for
that crap.

Note though, ide-tape is not anywhere near semantically
to the ide-scsi+st, because of its "sophisticated" (e.g. utterly
broken) internal pipeline. It does a lot of work underneath
the /dev boundary. Apparently, the author had a bad case of streaming
stoppages on his 386, so instead of fixing the root cause he
wrote the monster we have today. Getting rid of ide-tape may
cause problems on 386's. But then again, perhaps not.

-- Pete
