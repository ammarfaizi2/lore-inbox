Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130895AbRAWMpw>; Tue, 23 Jan 2001 07:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131136AbRAWMpt>; Tue, 23 Jan 2001 07:45:49 -0500
Received: from 213-120-138-151.btconnect.com ([213.120.138.151]:33796 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S130895AbRAWMpb>;
	Tue, 23 Jan 2001 07:45:31 -0500
Date: Tue, 23 Jan 2001 12:47:59 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Chmouel Boudjnah <chmouel@mandrakesoft.com>
cc: Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.1-pre8/10 klogd taking 100% of CPU time -- bug?
In-Reply-To: <m3y9w2a2d8.fsf@giants.mandrakesoft.com>
Message-ID: <Pine.LNX.4.21.0101231245140.916-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Jan 2001, Chmouel Boudjnah wrote:

> Andrew Morton <andrewm@uow.edu.au> writes:
> 
> > As far as the klogd problem is concerned, see
> > 
> > 	http://www.uwsg.iu.edu/hypermail/linux/kernel/0101.1/1053.html
> > 
> > for a probable solution.
> 
> it look like it fixes the problem for me, thanks.
> 

Yes, it works, but one should NOT forget to rename /sbin/syslogd ->
syslogd.old and klogd likewise because the new versions install themselves
into /usr/sbin and so without renaming the old versions will be picked up.
Also, one needs to edit /etc/rc.d/init.d/syslog. This is very similar to
what one has to do if he wants to use NFSv3 client/server and latest
nfsutils on Red Hat systems (they are broken by default)

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
