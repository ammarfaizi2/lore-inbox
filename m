Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293719AbSCKMrp>; Mon, 11 Mar 2002 07:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293718AbSCKMrf>; Mon, 11 Mar 2002 07:47:35 -0500
Received: from ns.ithnet.com ([217.64.64.10]:4356 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S293717AbSCKMra>;
	Mon, 11 Mar 2002 07:47:30 -0500
Date: Mon, 11 Mar 2002 13:47:17 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Oleg Drokin <green@namesys.com>
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
Message-Id: <20020311134717.65fafb85.skraw@ithnet.com>
In-Reply-To: <20020311141154.C856@namesys.com>
In-Reply-To: <shswuwkujx5.fsf@charged.uio.no>
	<200203110018.BAA11921@webserver.ithnet.com>
	<15499.64058.442959.241470@charged.uio.no>
	<20020311091458.A24600@namesys.com>
	<20020311114654.2901890f.skraw@ithnet.com>
	<20020311135256.A856@namesys.com>
	<20020311141154.C856@namesys.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2002 14:11:54 +0300
Oleg Drokin <green@namesys.com> wrote:

> So that's /dev/hdg1 that is reiserfs v3.5
> 
> > /dev/hdg1             20043416  16419444   3623972  82% /p3
> > Exported fs is on /dev/hde1.
> 
> Hm. Strange. Are you sure you do not export /dev/hdg1?

Ok, Oleg,

I re-checked the setup with all server fs as reiserfs 3.6 and the problem stays
the same.

Mar 11 13:05:07 admin kernel: reiserfs: checking transaction log (device 22:01)
...
Mar 11 13:05:09 admin kernel: Using r5 hash to sort names
Mar 11 13:05:09 admin kernel: ReiserFS version 3.6.25

What else can I try?

I checked the setup with another client kernel 2.4.18, and guess what: it has
the same problem. I have the impression that the problem is somewhere on the
nfs server side - possibly around the umount case. Trond, Ken?

Can anyone reproduce this? It should be fairly simple to check.

Regards,
Stephan

