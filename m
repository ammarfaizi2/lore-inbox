Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276675AbRJ2RLW>; Mon, 29 Oct 2001 12:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276642AbRJ2RLM>; Mon, 29 Oct 2001 12:11:12 -0500
Received: from mons.uio.no ([129.240.130.14]:45562 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S276641AbRJ2RLI>;
	Mon, 29 Oct 2001 12:11:08 -0500
To: "prabhakara_r" <prabhakara_r@indiatimes.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: nfs lockd error message
In-Reply-To: <200110291642.WAA30251@WS0005.indiatimes.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 29 Oct 2001 18:11:37 +0100
In-Reply-To: <200110291642.WAA30251@WS0005.indiatimes.com>
Message-ID: <shssnc2e5h2.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == prabhakara r <prabhakara_r> writes:

     > hi all,
     >    i am getting an error message "portmap: server localhost not
     >    responding, timed out" followed by "portmap: makesock
     >    failed, error = -5" after I recompiled the kernel with some
     >    changes in tcp files under ipv4 dir. the system hangs for
     >    minutes and then boots as usual. though i am damn sure that
     >    i haven't done any changes to NFS source code, i am still
     >    getting this error message. subsequently the system also
     >    shows "NFS lockd failed" while shutting down.could anyone of
     >    u pls tell me why i am getting this error and how to solve
     >    this problem.

The problem isn't with the kernel but with your setup. For some
reason, the kernel is unable to contact the portmapper in order to
register a service.

That can mean either that you are starting rpc.portmap after you start
lockd, or that you have blocked access from 'localhost' (either using
the tcp_wrappers, or using ipchains).

Cheers,
   Trond
