Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264509AbTK0MSp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 07:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264510AbTK0MSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 07:18:45 -0500
Received: from smtprelay01.ispgateway.de ([62.67.200.156]:60877 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S264509AbTK0MSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 07:18:40 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Andi Kleen <ak@suse.de>, arjanv@redhat.com
Subject: Re: Fire Engine??
Date: Thu, 27 Nov 2003 13:16:03 +0100
User-Agent: KMail/1.5.4
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
References: <BAY1-DAV15JU71pROHD000040e2@hotmail.com.suse.lists.linux.kernel> <1069882450.5219.1.camel@laptop.fenrus.com> <20031126235809.131fde15.ak@suse.de>
In-Reply-To: <20031126235809.131fde15.ak@suse.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200311271316.05147.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 26 November 2003 23:58, Andi Kleen wrote:
> On Wed, 26 Nov 2003 22:34:10 +0100
> Arjan van de Ven <arjanv@redhat.com> wrote:
> > question: do we need a timestamp for every packet or can we do one
> > timestamp per irq-context entry ? (eg one timestamp at irq entry time we
> > do anyway and keep that for all packets processed in the softirq)
>
> If people want the timestamp they usually want it to be accurate
> (e.g. for tcpdump etc.). of course there is already a lot of jitter
> in this information because it is done relatively late in the device
> driver (long after the NIC has received the packet)
>
> Just most people never care about this at all....

Yes, these people not caring just open a SOCK_STREAM or SOCK_DGRAM. I
don't see any field in msghdr, which contains the time.

Other people have packet sockets (or other special stuff) opened, which
is usally bound to a device or to a special RX/TX path. So we know,
which device does need it and which not.

If in doubt, there could be an sysctl option for exact time per device
or for all.

But I'm not really that familiar with the networking code, so please
ignore my ignorance on any issues here.


Regards

Ingo Oeser

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/xesDU56oYWuOrkARAr1sAJ9h/EywUCb9wGVCZiW9GbivMiEVsACghj74
dE4EdzeW84U7QcMi/o+Q9qE=
=70Cm
-----END PGP SIGNATURE-----

