Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280947AbRKLTSo>; Mon, 12 Nov 2001 14:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280944AbRKLTSd>; Mon, 12 Nov 2001 14:18:33 -0500
Received: from smtprelay6.dc2.adelphia.net ([64.8.50.38]:30915 "EHLO
	smtprelay6.dc2.adelphia.net") by vger.kernel.org with ESMTP
	id <S280941AbRKLTSD>; Mon, 12 Nov 2001 14:18:03 -0500
Message-ID: <00da01c16ba2$96aeda00$5101a8c0@pbc.adelphia.net>
From: "Ben Israel" <ben@genesis-one.com>
To: <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@zip.com.au>
In-Reply-To: <00b201c16b81$9d7aaba0$5101a8c0@pbc.adelphia.net> <3BEFF9D1.3CC01AB3@zip.com.au>
Subject: Re: File System Performance
Date: Mon, 12 Nov 2001 12:50:52 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew

 Thank you very much for your response. I would like to know what ever I can
about File Systems that achieve near Raw Disk Transfer Speeds on large file
system modifications. What does the "Orlov allocator" do differently? What
is
"slow growth" workload? All File Systems I've used have this problem. XFS is
just supposedly high performance. It offers some improvement, but is still
off by a factor of 4.

Andrew Morton wrote:

> Ben Israel wrote:
> >
> > ...
> > 128M SDRAM
> > ...
> > time cp -r /usr/src/linux-2.4.6 tst
> > ...
> > 2*144MB/48s=6MB/sec
> >
>
> There was some discussion about this last week.  It appears to
> be due to ext2's directory placement policy.  Al Viro has a
> patch which implements the "Orlov allocator" which FreeBSD are
> using.
>
> It works, and it'll get you close to disk bandwidth with this test.
> But the effects of this change on other workloads (the so-called
> "slow growth" scenario) still needs to be understood and tested.
>
> -


