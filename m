Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313911AbSEDOz2>; Sat, 4 May 2002 10:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313904AbSEDOz1>; Sat, 4 May 2002 10:55:27 -0400
Received: from pat.uio.no ([129.240.130.16]:54250 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S313762AbSEDOzZ>;
	Sat, 4 May 2002 10:55:25 -0400
To: "Brian Dixon" <dixonbp@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NFS locking routines do not invoke the filesystem lock operation
In-Reply-To: <OF676A9D08.8758D24B-ON85256BAE.00716BCE@raleigh.ibm.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 04 May 2002 16:55:19 +0200
Message-ID: <shsn0vgync8.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Brian Dixon <dixonbp@us.ibm.com> writes:

     > Submitting a patch for NFS locking that has been part of the
     > -ac tree since 2.4.2-ac4 but has never picked-up in the base
     > kernel.

There's a good reason why not. This sort of thing can hang your lockd
process: sleeping in lockd is unacceptable. Period...

Cheers,
  Trond
