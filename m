Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129272AbRBCO6G>; Sat, 3 Feb 2001 09:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129301AbRBCO55>; Sat, 3 Feb 2001 09:57:57 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:26355 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129272AbRBCO5r>; Sat, 3 Feb 2001 09:57:47 -0500
To: "J . A . Magallon" <jamagallon@able.es>
Cc: "H . Peter Anvin" <hpa@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] tmpfs for 2.4.1
In-Reply-To: <20010123205315.A4662@werewolf.able.es>
	<m3lmrqrspv.fsf@linux.local> <95csna$vb6$1@cesium.transmeta.com>
	<m3puh1que4.fsf@linux.local> <20010202215254.C2498@werewolf.able.es>
	<3A7B1EDC.DA2588BA@transmeta.com>
	<20010203010649.E3014@werewolf.able.es>
From: Christoph Rohland <cr@sap.com>
In-Reply-To: <20010203010649.E3014@werewolf.able.es>
Message-ID: <m3zog3omik.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 03 Feb 2001 16:02:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J . A . Magallon" <jamagallon@able.es> writes:

> I did not get the chance to deal too much with it, but apart from moving
> functionality from userspace (ipcs) to kernel (ls), what were/could be the
> benefits of /dev/shm ?. Can you create a shared memory segment by simply
> creating a file there, or it is just a picture of what is in kernelspace?.

The most appealing thing to me was rm -f /dev/shm/.IPC* :-) So I
should make a patch to ipcrm to allow multiple segments (and
wildcards?).

You could not create SYSV shm segments with open, but you could delete
them with rm and list the with ls.

> First time I saw that I thought: what could happen if /dev/shm is shared
> in a cluster ? or, lets suppose that /dev/shm is a logical volume made by
> addition of some nfs mounted volumes, one of each node, so one piece of
> the shm fs is local and other remote...kinda DSM/NUMA...?

No, this was never possible. It was only a fs interface to local
kernel objects (and still is).

> (just too much marijuana late at night...)

Oh, you are allowed to dream ;-)

Greetings
                Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
