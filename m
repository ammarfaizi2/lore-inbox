Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263479AbUCTRP0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 12:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263481AbUCTRPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 12:15:25 -0500
Received: from gw0.infiniconsys.com ([65.219.193.226]:23308 "EHLO
	mail.infiniconsys.com") by vger.kernel.org with ESMTP
	id S263479AbUCTRPX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 12:15:23 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Re: PATCH - InfiniBand Access Layer (IBAL)
Date: Sat, 20 Mar 2004 12:15:23 -0500
Message-ID: <08628CA53C6CBA4ABAFB9E808A5214CB01EE9AD7@mercury.infiniconsys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: PATCH - InfiniBand Access Layer (IBAL)
Thread-Index: AcQOnunO+ECrJ/izRbWW/zSJ0/jttA==
From: "Acker, Dave" <dacker@infiniconsys.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper <drepper@redhat.com> wrote in message
news:<1ByNc-1km-21@gated-at.bofh.it>...
> 
> First, the working group I refer to is this:
> 
>   http://www.opengroup.org/icsc/
> 
> But that's all there is.  The socket extension working group
> 
>   http://www.opengroup.org/icsc/sockets/
> 

Most of us IB folks wanted to work with the ICSC stuff waaaaay back but
it never went anywhere and we all had to ship products.  So various
stacks developed.  All that is being specified by the ICSC is an API.
There are already several APIs into IB that are not IB specific.
These include:
DAPL - http://www.datcollaborative.org/,
http://sourceforge.net/projects/dapl/ 
MPI - http://www-unix.mcs.anl.gov/mpi/ 
SDP - (not really an API but is run over IB verbs and RDMA verbs and
meets up with your sockets note) See InfiniBand Specification, Volume 1,
Annex A4, Release 1.1, http://www.rdmaconsortium.org/home 

There is no reason we can't implement support for the ICSC APIs if the
Linux community desires this.  I can say that these other APIs are
already being used by other programs (or other APIs themselves) and
really can't go away.  If folks ask for ICSC support, it will probably
get in there.

> So, these people come up with their own software stacks, unreviewed
> interface extensions, and demand that everybody accepts what they were
> "designing" without the ability to question anything.
> I surely find this completely  unacceptable and any consideration of
> accepting anything the Infiniband group comes up with should be
> postponed until every bit of the design can be reviewed.  If bits and
> pieces are accepted prematurely it'll just be "now that this is
support
> you have to add this too, otherwise it'll not be useful".

While some of the same people were on the ICSC lists as the IBTA lists
or the DAT lists, it doesn't mean that they are operating as one big
group with some secret agenda.  The ICSC group went one way and only
recently produced a spec.  The DAT group went another and has had a spec
for some time.  The RDMA folks went yet another and produced a spec a
bit ago.  While there are some people in both groups, the groups act
independently with different companies and individuals have more
control/influence in one than the other.

All that said, the IB developer community has decided as a whole to open
things up.  InfiniCon, TopSpin, Voltaire, DivergeNet, Mellanox, etc.
have all opened up their code.  Add to this the already started open
effort on sourceforge (IBAL) and we hope to find a best of breed final
solution.  So please do review every single bit posted.  If there is
going to be a standard linux infiniband stack it will have to be very
good or else splinter versions and incompatible versions will live on.

-Ack

p.s. While I may work for an IB company, I am expressing my own
opinions, not their official opinions.
