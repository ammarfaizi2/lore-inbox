Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272676AbRIGOmZ>; Fri, 7 Sep 2001 10:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272679AbRIGOmP>; Fri, 7 Sep 2001 10:42:15 -0400
Received: from pat.uio.no ([129.240.130.16]:2440 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S272676AbRIGOmK>;
	Fri, 7 Sep 2001 10:42:10 -0400
MIME-Version: 1.0
Message-ID: <15256.56528.460569.700469@charged.uio.no>
Date: Fri, 7 Sep 2001 16:42:24 +0200
To: "Mike Black" <mblack@csihq.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.8 NFS Problems
In-Reply-To: <033a01c1379e$e3514880$e1de11cc@csihq.com>
In-Reply-To: <024f01c13601$c763d3c0$e1de11cc@csihq.com>
	<shsae07md9d.fsf@charged.uio.no>
	<033a01c1379e$e3514880$e1de11cc@csihq.com>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Mike Black <mblack@csihq.com> writes:

     > But my timeouts were only 10 seconds -- well below the timeo
     > and retrans timeout periods.  And my network traffic shows that

According to the 'nfs' manpage, the default timeo on the mount in
util-linux is usually 0.7 seconds. retrans is 3.

  0.7 + 1.4 + 2.8 = 4.9 seconds < 10...

     > this is the client causing the problem NOT the server.  It's
     > the read() that pauses for 10 seconds and then the NFS write
     > immediately returns EIO.  So...I don't think soft mounts has
     > anything to do with it.

I think it does.

Cheers,
  Trond
