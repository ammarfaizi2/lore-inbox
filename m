Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281479AbRKTXST>; Tue, 20 Nov 2001 18:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281485AbRKTXSJ>; Tue, 20 Nov 2001 18:18:09 -0500
Received: from mons.uio.no ([129.240.130.14]:8614 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S281479AbRKTXRw>;
	Tue, 20 Nov 2001 18:17:52 -0500
To: "Dan Maas" <dmaas@dcine.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Swap
In-Reply-To: <fa.kb6ct7v.pgku0d@ifi.uio.no> <fa.k8qdvcv.184ak2l@ifi.uio.no>
	<040701c17215$357711c0$1a01a8c0@allyourbase>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 21 Nov 2001 00:17:44 +0100
In-Reply-To: <040701c17215$357711c0$1a01a8c0@allyourbase>
Message-ID: <shsitc5kp5z.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Dan Maas <dmaas@dcine.com> writes:

     > But NFS still allows atomic rename() right? Isn't it considered
     > essential to write the new executable or library under a
     > different name, and then atomically rename() over the old one? 
     > If you write() directly into the executable, you will get what
     > you deserve...

Atomic rename works fine, on NFS, so if you just rename the old
library, you're quite safe. The bugs start to surface if you:

   a) Reuse the the old library's inode by doing something along the
      lines of open("lib.so",O_TRUNC|O_WRONLY).
or
   b) erase the old library.

Cheers,
   Trond
