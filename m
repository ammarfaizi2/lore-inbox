Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292232AbSBTTnU>; Wed, 20 Feb 2002 14:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292245AbSBTTnK>; Wed, 20 Feb 2002 14:43:10 -0500
Received: from mons.uio.no ([129.240.130.14]:42888 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S292232AbSBTTm4>;
	Wed, 20 Feb 2002 14:42:56 -0500
To: "Peter J. Braam" <braam@clusterfs.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: tmpfs, NFS, file handles
In-Reply-To: <20020220094649.X25738@lustre.cfs>
	<3C73D548.648C5D64@mandrakesoft.com>
	<20020220122116.C28913@lustre.cfs>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 20 Feb 2002 20:42:50 +0100
In-Reply-To: <20020220122116.C28913@lustre.cfs>
Message-ID: <shsk7t82b45.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Peter J Braam <braam@clusterfs.com> writes:

     > Would the following also work?

     > - have a 32 bit counter: set inode->i_ino to count++

That is exactly what iunique() does except that it also checks for
uniqueness and allows you to specify a minimum value. Sooner or later
your 32-bit counter will wrap round...

     > - up the generation number each time the counter warps.

     > Between boot cycles NFS could still get confused, that might be
     > helped by setting the initial generation to the system time.

Yep. That is what the 'fat' filesystem does.

Cheers,
  Trond
