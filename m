Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130508AbQL0NT5>; Wed, 27 Dec 2000 08:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130541AbQL0NTr>; Wed, 27 Dec 2000 08:19:47 -0500
Received: from relay.hq.tis.com ([192.94.214.100]:7577 "EHLO
	sentry.gw.tislabs.com") by vger.kernel.org with ESMTP
	id <S130508AbQL0NTj>; Wed, 27 Dec 2000 08:19:39 -0500
Date: Wed, 27 Dec 2000 07:48:04 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Kurt Garloff <garloff@suse.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: The NSA's Security-Enhanced Linux (fwd)
In-Reply-To: <20001223052232.N17117@garloff.etpnet.phys.tue.nl>
Message-ID: <Pine.SOL.3.95.1001227073426.17706D-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 23 Dec 2000, Kurt Garloff wrote:

> I wonder how their approach compares to the RSBAC stuff, though.
> The RSBAC (by Amon Ott) has all the infrastructure available to have
> policy based access control; whenever an access decision has to be
> taken, a call via some interface is made to a module, which then
> takes the decision ... Just like PAM in userspace.
> http://www.rsbac.org/

The Security-Enhanced Linux has a well-defined architecture (named Flask)
for flexible mandatory access controls that has been experimentally
validated through several prototype systems (DTMach, DTOS, and Flask).
The architecture provides clean separation of policy from enforcement,
well-defined policy decision interfaces, flexibility in labeling
and access decisions, support for policy changes, and fine-grained
controls over the kernel abstractions.  Detailed studies have been
performed of the ability of the architecture to support a wide variety of
security policies and are available on the DTOS and Flask web pages
accessible via the Background page
(http://www.nsa.gov/selinux/background.html).  A published paper about
the Flask architecture is also available on the Background page.  The
architecture and its implementation in Linux are described in detail in
the documentation (http://www.nsa.gov/selinux/docs.html).  

RSBAC appears to have similar goals to the Security-Enhanced Linux.
Like the Security-Enhanced Linux, it separates policy from enforcement
and supports a variety of security policies.  RSBAC uses a different
architecture (the Generalized Framework for Access Control or GFAC) than
the Security-Enhanced Linux, although the Flask paper notes that at the
highest level of abstraction, the the Flask architecture is consistent
with the GFAC.  However, the GFAC does not seem to fully address the issue
of policy changes and revocation, as discussed in the Flask paper.  RSBAC
also differs in the specifics of its policy interfaces and its controls,
but a careful evaluation of the significance of these differences has
not been performed.

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
