Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268205AbTBMS6k>; Thu, 13 Feb 2003 13:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268207AbTBMS6k>; Thu, 13 Feb 2003 13:58:40 -0500
Received: from pat.uio.no ([129.240.130.16]:44509 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S268205AbTBMS6i>;
	Thu, 13 Feb 2003 13:58:38 -0500
To: Joel Becker <Joel.Becker@oracle.com>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.60 NFS FSX
References: <20030213152742.GA1560@codemonkey.org.uk>
	<20030213185410.GN20972@ca-server1.us.oracle.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 13 Feb 2003 20:08:21 +0100
In-Reply-To: <20030213185410.GN20972@ca-server1.us.oracle.com>
Message-ID: <shsd6lwati2.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Joel Becker <Joel.Becker@oracle.com> writes:

     > On Thu, Feb 13, 2003 at 03:27:42PM +0000, Dave Jones wrote:
    >> 2.5.60's NFS seems to have various issues.  (2.5.60 client,
    >> 2.4.21pre3 server)

     > 	I get these a lot:

     > NFS: server cheating in read reply: count 1115 recvd 1000

     > 	The counts are various and not consistent.

Does either you have a tcpdump you could send me of one of the above
events? Use a large snaplen since we want to check the readdir reply
length (which tends to be ~4k). Something like

   tcpdump -s 8192 -w dump.out host blah and port 2049

Cheers,
  Trond
