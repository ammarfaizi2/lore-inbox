Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262457AbSK0MyN>; Wed, 27 Nov 2002 07:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262464AbSK0MyN>; Wed, 27 Nov 2002 07:54:13 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:25004 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S262457AbSK0MyM>;
	Wed, 27 Nov 2002 07:54:12 -0500
Date: Thu, 28 Nov 2002 00:00:26 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, anton@samba.org,
       ak@muc.de, davidm@hpl.hp.com, schwidefsky@de.ibm.com, ralf@gnu.org,
       willy@debian.org
Subject: Re: [PATCH] Start of compat32.h (again)
Message-Id: <20021128000026.6bd71217.sfr@canb.auug.org.au>
In-Reply-To: <20021126.235810.22015752.davem@redhat.com>
References: <20021127184228.2f2e87fd.sfr@canb.auug.org.au>
	<20021126.235810.22015752.davem@redhat.com>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Tue, 26 Nov 2002 23:58:10 -0800 (PST) "David S. Miller" <davem@redhat.com> wrote:
>
>    From: Stephen Rothwell <sfr@canb.auug.org.au>
>    Date: Wed, 27 Nov 2002 18:42:28 +1100
> 
>    How's this one :-)
>    
> I don't think this is the way to go.
> 
> I think we really need to give the 32-bit compatability
> types names and allow 64-bit arches to define what their
> 32-bit counterparts use.

OK, we can discuss that as well, but what do you think of the particular
patch that I supplied?  It is independent of the naming of types.  If I
can get linux/compat32.h and CONFIG_COMPAT32 started, the consolidation
will preceed fairly rapidly and I think that is far more important than
what the names look like ...

> For example, nlink_t is going to need to be different
> for sparc 32-bit compat vs. most other platforms because
> we use a signed short there.

This will be allowed for when linux/compat32.h includes asm/compat32.h
at a later stage.  asm/compat32.h will be expected to have typedefs for
compat32_<type> (or __kernel_<type>32 whatever) for all the types that
vary between the architectures.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
