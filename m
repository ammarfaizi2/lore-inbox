Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310517AbSDMUlM>; Sat, 13 Apr 2002 16:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310637AbSDMUlL>; Sat, 13 Apr 2002 16:41:11 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37957 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S310517AbSDMUlL>; Sat, 13 Apr 2002 16:41:11 -0400
To: Andi Kleen <ak@suse.de>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
        "David S. Miller" <davem@redhat.com>, taka@valinux.co.jp,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zerocopy NFS updated
In-Reply-To: <20020412.213011.45159995.taka@valinux.co.jp>
	<20020412143559.A25386@wotan.suse.de>
	<20020412222252.A25184@kushida.apsleyroad.org>
	<20020412.143150.74519563.davem@redhat.com>
	<20020413012142.A25295@kushida.apsleyroad.org>
	<20020413083952.A32648@wotan.suse.de>
	<m1662vjtil.fsf@frodo.biederman.org>
	<20020413213700.A17884@wotan.suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 Apr 2002 14:34:12 -0600
Message-ID: <m1zo07ibi3.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> On Sat, Apr 13, 2002 at 01:19:46PM -0600, Eric W. Biederman wrote:
> > Could the garbage from ext3 in writeback mode be considered an
> > information leak?  I know that is why most places in the kernel
> > initialize pages to 0.  So you don't accidentally see what another
> > user put there.
> 
> Yes it could. But then ext2/ffs have the same problem and so far people were
> able to live on with that.

The reason I asked, is the description sounded specific to ext3.  Also
with ext3 a supported way to shutdown is to just pull the power on the
machine.  And the filesystem comes back to life without a full fsck.

So if this can happen when all you need is to replay the journal, I
have issues with it.  If this happens in the case of damaged
filesystem I don't.

Eric
