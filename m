Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281627AbRKUGbN>; Wed, 21 Nov 2001 01:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281631AbRKUGay>; Wed, 21 Nov 2001 01:30:54 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:6784 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S281624AbRKUGad>; Wed, 21 Nov 2001 01:30:33 -0500
Date: Wed, 21 Nov 2001 00:33:04 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Re: [VM/MEMORY-SICKNESS] 2.4.15-pre7 kmem_cache_create invalid opcode
Message-ID: <20011121003304.A683@vger.timpanogas.org>
In-Reply-To: <20011121001639.A813@vger.timpanogas.org> <20011120.222203.58448986.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011120.222203.58448986.davem@redhat.com>; from davem@redhat.com on Tue, Nov 20, 2001 at 10:22:03PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2001 at 10:22:03PM -0800, David S. Miller wrote:
> 
> Your code is violating one of the assertions in
> kmem_cache_create(), check the BUG(); calls in
> mm/slab.c:kmem_cache_create() to try and figure out
> which one you are firing off.
> 
> Probably either you are trying to send it debug flags
> but CONFIG_SLAB_DEBUG is not defined _OR_ you are trying
> to create the same SLAB cache twice (forgetting to destroy
> it on module unload perhaps)?
> 
> Slab if fine, it's your code which is busted :)

David,

I need some help here (big surprise).  I did nothing other than 
download pre7, apply my patch, and do the build.  I went back 
over how I did the build, and this is the result of the build 
if you have unpacked, patched, then run "make oldconfig."  If I
do a "make dep" then this problem does not occur, and the build 
works fine.  If I build the external module (this bug only 
shows up when building the external module file system driver,
not the kernel patched version of NWFS).

No. I think the build in linux is broken.  The Linux tree should 
not generate garbase opcodes from the includes is make dep 
has not been run and someone is simply building a module against
the include files.

:-)

Jeff

