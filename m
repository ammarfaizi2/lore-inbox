Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314260AbSDRHHm>; Thu, 18 Apr 2002 03:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314261AbSDRHHl>; Thu, 18 Apr 2002 03:07:41 -0400
Received: from mons.uio.no ([129.240.130.14]:57275 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S314260AbSDRHHl>;
	Thu, 18 Apr 2002 03:07:41 -0400
To: Robert Love <rml@tech9.net>
Cc: Alex Riesen <riesen@synopsys.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre7+preempt: rpciod[178] exited with preempt_count 1
In-Reply-To: <20020417224222.A184@steel> <1019102300.5395.33.camel@phantasy>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 18 Apr 2002 09:06:20 +0200
Message-ID: <shslmblh4er.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Robert Love <rml@tech9.net> writes:

     > On Wed, 2002-04-17 at 16:42, Alex Riesen wrote:
    >> just tried your preempt-kernel-rml-2.4.19-pre7-1.patch.  I'm
    >> using automount (v4) here and am getting this in syslog:
    >>
    >> Apr 17 22:32:26 steel kernel: lockd[190] exited with
    >> preempt_count 1 Apr 17 22:32:26 steel kernel: rpciod[189]
    >> exited with preempt_count 1
    >>
    >> Every time automounter decides to drop an nfs mount.  Some time
    >> ago i've read on lkml that such kind of messages aren't very
    >> good to see, so decided to drop you a note.

     > It is most likely caused by nfs neglecting to drop a lock when
     > it exits

That would be the BKL. We do it for rpciod, lockd and the lock
reclaimers. AFAIK that should never be a problem.

Cheers,
  Trond
