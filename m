Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280823AbRKLQeW>; Mon, 12 Nov 2001 11:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280834AbRKLQeM>; Mon, 12 Nov 2001 11:34:12 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:47118 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S280823AbRKLQeD>; Mon, 12 Nov 2001 11:34:03 -0500
Message-ID: <3BEFF9D1.3CC01AB3@zip.com.au>
Date: Mon, 12 Nov 2001 08:33:21 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ben Israel <ben@genesis-one.com>
CC: linux-kernel@vger.kernel.org, "John O'Neil" <joneil@genesis-one.com>
Subject: Re: File System Performance
In-Reply-To: <00b201c16b81$9d7aaba0$5101a8c0@pbc.adelphia.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Israel wrote:
> 
> ...
> 128M SDRAM
> ...
> time cp -r /usr/src/linux-2.4.6 tst
> ...
> 2*144MB/48s=6MB/sec
> 

There was some discussion about this last week.  It appears to
be due to ext2's directory placement policy.  Al Viro has a 
patch which implements the "Orlov allocator" which FreeBSD are
using.

It works, and it'll get you close to disk bandwidth with this test.
But the effects of this change on other workloads (the so-called
"slow growth" scenario) still needs to be understood and tested.

-
