Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265108AbSK1Cix>; Wed, 27 Nov 2002 21:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265111AbSK1Cix>; Wed, 27 Nov 2002 21:38:53 -0500
Received: from pat.uio.no ([129.240.130.16]:48567 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S265108AbSK1Cix>;
	Wed, 27 Nov 2002 21:38:53 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15845.33640.256556.123111@charged.uio.no>
Date: Thu, 28 Nov 2002 03:46:00 +0100
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
       Ext2 devel <ext2-devel@lists.sourceforge.net>,
       NFS maillist <nfs@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [Ext2-devel] Re: [NFS] htree+NFS (NFS client bug?)
In-Reply-To: <1038449223.1464.17.camel@ixodes.goop.org>
References: <1038354285.1302.144.camel@sherkaner.pao.digeo.com>
	<shsptsrd761.fsf@charged.uio.no>
	<1038387522.31021.188.camel@ixodes.goop.org>
	<20021127150053.A2948@redhat.com>
	<1038449223.1464.17.camel@ixodes.goop.org>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Jeremy Fitzhardinge <jeremy@goop.org> writes:

     > Hm, I just did a run with 8k NFS packets, and the results are
     > slightly different.  There's only a single READDIR reply,
     > fragmented over 3 IP packets.  vg_include.h~51-kill-inceip
     > still has a cookie of 1611747420, and vg_libpthread.vs is still
     > the last entry returned, but it has a cookie of 0.  As far as I
     > can see, all the other cookies are unique.

AFAICS, the ext2/ext3 code is simply failing to initialize that last
cookie, and so knfsd is giving it the value of the cookie that was
passed by the client.

Cheers,
  Trond
