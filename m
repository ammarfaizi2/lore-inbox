Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272801AbTHFFNR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 01:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274870AbTHFFNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 01:13:17 -0400
Received: from almesberger.net ([63.105.73.239]:50443 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S272801AbTHFFNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 01:13:16 -0400
Date: Wed, 6 Aug 2003 02:13:04 -0300
From: Werner Almesberger <werner@almesberger.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Nivedita Singhvi <niv@us.ibm.com>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: TOE brain dump
Message-ID: <20030806021304.E5798@almesberger.net>
References: <20030802140444.E5798@almesberger.net> <3F2BF5C7.90400@us.ibm.com> <3F2C0C44.6020002@pobox.com> <20030802184901.G5798@almesberger.net> <m1fzkiwnru.fsf@frodo.biederman.org> <20030804162433.L5798@almesberger.net> <m1u18wuinm.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1u18wuinm.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Tue, Aug 05, 2003 at 11:19:09AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> MPI is not a transport.  It an interface like the Berkeley sockets
> layer.

Hmm, but doesn't it also unify transport semantics (i.e. chop
TCP streams into messages), maybe add reliability to transports
that don't have it, and provide addressing ? Okay, perhaps you
wouldn't call this a transport in the OSI sense, but it still
seems to have considerably more functionality than just
providing an API.

> Mostly I think the that is less true, at least if they can stand the
> process of severe code review and cleaning up their code.

Hmm, people putting dozens of millions into building clusters
can't afford to have what is probably their most essential
infrastructure code reviewed and cleaned up ? Oh dear.

> But of course to get through the peer review process people need
> to understand what they are doing.

A good point :-)

> So store and forward of packets in a 3 layer switch hierarchy, at 1.3 us
> per copy.

But your switch could just do cut-through, no ? Or do they
need to recompute checksums ?

> A lot of the NICs which are used for MPI tend to be smart for two
> reasons.  1) So they can do source routing. 2) So they can safely
> export some of their interface to user space, so in the fast path
> they can bypass the kernel.

The second part could be interesting for TOE, too. Only that
the interface exported would just be the socket interface.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
