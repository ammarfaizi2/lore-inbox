Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268071AbTBMPfp>; Thu, 13 Feb 2003 10:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268072AbTBMPfo>; Thu, 13 Feb 2003 10:35:44 -0500
Received: from mons.uio.no ([129.240.130.14]:47812 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S268071AbTBMPfo>;
	Thu, 13 Feb 2003 10:35:44 -0500
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.60 NFS FSX
References: <20030213152742.GA1560@codemonkey.org.uk>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 13 Feb 2003 16:45:27 +0100
In-Reply-To: <20030213152742.GA1560@codemonkey.org.uk>
Message-ID: <shs4r78yyjs.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Dave Jones <davej@codemonkey.org.uk> writes:

     > 2.5.60's NFS seems to have various issues.  (2.5.60 client,
     > 2.4.21pre3 server)

     > - I ran an fsx and an fsstress in parallel.
     >   Client rebooted after 2-3 minutes.

I know. There's memory corruption going on somewhere, but I'm not sure
exactly where.

     > - fsx on its own, after quite a while, this happens..

Also known. It's a bit odd really: the reads fail due to some form of
corruption, but the writes are OK. Means that when you later come to
compare the '.fsxgood' file to the 'bad' file, then things look OK.

I'm a bit confused w.r.t. both these issues. Neither occur on the
2.4.x platform despite the fact that the code is more or less the
same. This is why I suspect an IPv4 socket problem.

Cheers,
  Trond
