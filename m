Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbRAPPh0>; Tue, 16 Jan 2001 10:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129792AbRAPPhR>; Tue, 16 Jan 2001 10:37:17 -0500
Received: from penguin.roanoke.edu ([199.111.154.8]:42510 "EHLO
	penguin.roanoke.edu") by vger.kernel.org with ESMTP
	id <S129511AbRAPPhI>; Tue, 16 Jan 2001 10:37:08 -0500
Message-ID: <3A646CBB.3D4355E5@linuxjedi.org>
Date: Tue, 16 Jan 2001 10:46:03 -0500
From: "David L. Parsley" <parsley@linuxjedi.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jakub Jelinek <jakub@redhat.com>, linux-kernel@vger.kernel.org,
        leitner@convergence.de, mingo@elte.hu
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <20010116114018.A28720@convergence.de> <Pine.LNX.4.30.0101161338270.947-100000@elte.hu> <20010116134737.A29366@convergence.de> <20010116144849.B19949@pcep-jamie.cern.ch> <20010116152023.A32180@convergence.de> <3A646322.B76A1661@linuxjedi.org> <20010116100506.C1120@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Jelinek wrote:

> > This makes me wonder...
> > 
> > If the kernel only kept a queue of the three smallest unused fd's, and
> > when the queue emptied handed out whatever it liked, how many things
> > would break?  I suspect this would cover a lot of bases...
> 
> First it would break Unix98 and other standards:
[snip]

Yeah, I reallized it would violate at least POSIX.  The discussion was
just bandying about ways to avoid an expensive 'open()' without breaking
lots of utilities and glibc stuff.  This might be something that could
be configured for specific server environments, where performance is
more imporant than POSIX/Unix98, but you still don't want to completely
break the system.  Just a thought, brain-damaged as it might be. ;-)

regards,
	David

-- 
David L. Parsley
Network Administrator
Roanoke College
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
