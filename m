Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281077AbRLUMb1>; Fri, 21 Dec 2001 07:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281009AbRLUMbR>; Fri, 21 Dec 2001 07:31:17 -0500
Received: from pat.uio.no ([129.240.130.16]:21477 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S280984AbRLUMbC>;
	Fri, 21 Dec 2001 07:31:02 -0500
To: Michael Kummer <michael@kummer.cc>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: Received erroneous SM_UNMON
In-Reply-To: <Pine.LNX.4.40.0112211151080.242-100000@warp4>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 21 Dec 2001 13:15:39 +0100
In-Reply-To: <Pine.LNX.4.40.0112211151080.242-100000@warp4>
Message-ID: <shsbsgsvkes.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Michael Kummer <frost@packetst0rm.net> writes:

     > what does that mean?  <snip> Dec 21 11:49:28 freedom
     > rpc.statd[104]: Received erroneous SM_UNMON request from
     > freedom for 192.168.88.100 Dec 21 11:49:28 kryton
     > rpc.statd[13057]: Received erroneous SM_UNMON request from
     > kryton for 195.58.191.166 <snip>

The above question is pretty much off-topic for Linux Kernel...

Basically it means that your rpc.statd daemon is unaware of a lot of
its clients. It is probably failing to save their IP-numbers to disk.
Check therefore that the directories /var/lib/nfs/sm, and
/var/lib/nfs/sm.bak (or /var/lib/nfs/statd/sm, ... on some platforms)
are writable by the rpc.statd process.

Cheers,
  Trond
