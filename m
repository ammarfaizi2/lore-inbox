Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280978AbRLQQHT>; Mon, 17 Dec 2001 11:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281005AbRLQQHJ>; Mon, 17 Dec 2001 11:07:09 -0500
Received: from pat.uio.no ([129.240.130.16]:7344 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S280978AbRLQQGu>;
	Mon, 17 Dec 2001 11:06:50 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15390.6164.233273.513319@charged.uio.no>
Date: Mon, 17 Dec 2001 17:06:44 +0100
To: Dave Jones <davej@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: More fun with fsx.
In-Reply-To: <Pine.LNX.4.33.0112171537140.28670-100000@Appserv.suse.de>
In-Reply-To: <Pine.LNX.4.33.0112171523460.28670-100000@Appserv.suse.de>
	<Pine.LNX.4.33.0112171537140.28670-100000@Appserv.suse.de>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Dave Jones <davej@suse.de> writes:

     > Here's an interesting one.. Run two instances of fsx together
     > using the same test file..

     > ./fsx -c666 /mnt/nfs/noodles/test ./fsx -c667
     > /mnt/nfs/noodles/test

     > I typoed the 2nd line (and meant to do 'test2' concurrently)
     > Some kind of file locking problem?

Is that supposed to work? That gives 2 programs messing with the same
file 'test', but since the variable 'good_buf' is not shared, I'd
expect failure.

Cheers,
   Trond
