Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131315AbQJ2SfR>; Sun, 29 Oct 2000 13:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131535AbQJ2SfH>; Sun, 29 Oct 2000 13:35:07 -0500
Received: from lilac.csi.cam.ac.uk ([131.111.8.44]:26875 "EHLO
	lilac.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S131315AbQJ2Sex>; Sun, 29 Oct 2000 13:34:53 -0500
Date: Sun, 29 Oct 2000 18:34:46 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Raul Miller <moth@magenta.com>, linux-kernel@vger.kernel.org
Subject: Re: guarantee_memory() syscall?
In-Reply-To: <m1n1fn7ozi.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.10.10010291832510.20547-100000@dax.joh.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Oct 2000, Eric W. Biederman wrote:

> Raul Miller <moth@magenta.com> writes:
> 
> > Can anyone tell me about the viability of a guarantee_memory() syscall?
> > 
> > [I'm thinking: it would either kill the process, or allocate all virtual
> > memory needed for its shared libraries, buffers, allocated memory, etc.
> > Furthermore, it would render this process immune to the OOM killer,
> > unless it allocated further memory.]
> 
> Except for the OOM killer semantics mlockall already exists.

More to the point, "immortality" is NOT a desirable "feature": the OOM
killer just kills things which must be killed to protect the overall
system. We'll have a finely adjustable memory killer daemon soon, which
will be a better solution.


James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
