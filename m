Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264281AbTLKCUE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 21:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264303AbTLKCUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 21:20:04 -0500
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:25022 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S264281AbTLKCUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 21:20:00 -0500
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS errors in 2.6
References: <buobrqhun6r.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<shsu148ajbv.fsf@guts.uio.no>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 11 Dec 2003 11:19:55 +0900
In-Reply-To: <shsu148ajbv.fsf@guts.uio.no>
Message-ID: <buooeugccz8.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> writes:
>      > Network File System, READDIRPLUS Reply Error:ERR_INVAL
>      >     Program Version: 3 V3 Procedure: READDIRPLUS (17) Status:
>      >     ERR_INVAL (22) dir_attributes
> 
> Interesting. That actually looks like an error on the part of your
> Solaris server. NFS3ERR_INVAL is not a valid return code for either
> READDIR or for READDIRPLUS according to RFC1813.

Hmmm; I did a packet-trace on the 2.4.23 traffic for the same user
command, and it doesn't use READDIRPLUS at all (does 2.4.23 not support
NFS V3, or does it just use a different algorithm for reading
directories?), so maybe the server's just broken.  Gah...

> Is the server being kept up to scratch on the patch side?

No clue, but I suspect the answer is `sort of' (we don't have a real
sysadmin staff, but the people who take care of the servers are not
entirely clueless).  I'll check on it.

Thanks,

-Miles
-- 
We have met the enemy, and he is us.  -- Pogo
