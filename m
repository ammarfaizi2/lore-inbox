Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263093AbUF3Ww3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263093AbUF3Ww3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 18:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbUF3Ww3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 18:52:29 -0400
Received: from mail.shareable.org ([81.29.64.88]:30637 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262730AbUF3WwZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 18:52:25 -0400
Date: Wed, 30 Jun 2004 23:52:20 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Jakub Jelinek <jakub@redhat.com>
Cc: "David S. Miller" <davem@redhat.com>, wesolows@foobazco.org,
       sparclinux@vger.kernel.org, ultralinux@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: A question about PROT_NONE on Sparc and Sparc64
Message-ID: <20040630225220.GA32560@mail.shareable.org>
References: <20040630030503.GA25149@mail.shareable.org> <20040630082804.GS21264@devserv.devel.redhat.com> <20040630135419.25b843b8.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040630135419.25b843b8.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Wed, 30 Jun 2004 04:28:05 -0400
> Jakub Jelinek <jakub@redhat.com> wrote:
> 
> > I believe R!X and X!R pages ought to be possible on sparc64 too,
> > just use a different bit as "read" in the fast ITLB miss handler
> > from the one fast DTLB miss uses.
> 
> That's correct.  But I have no plans to implement this
> any time soon :-)

The PaX security patch already implements R!X pages on Sparc64, so you
could just cut out that part of the patch.  Just pick out the changes
to arch/sparc64/* and include/asm-sparc64/*:

	http://pax.grsecurity.net/pax-linux-2.6.7-200406252135.patch

It appears to use exactly the technique Jakub describes, and has been tested.

-- Jamie
