Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131489AbRA0GUh>; Sat, 27 Jan 2001 01:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131444AbRA0GUR>; Sat, 27 Jan 2001 01:20:17 -0500
Received: from vitelus.com ([64.81.36.147]:11788 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S131349AbRA0GUL>;
	Sat, 27 Jan 2001 01:20:11 -0500
Date: Fri, 26 Jan 2001 22:20:03 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
Message-ID: <20010126222003.A11994@vitelus.com>
In-Reply-To: <3A726087.764CC02E@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3A726087.764CC02E@uow.edu.au>; from andrewm@uow.edu.au on Sat, Jan 27, 2001 at 04:45:43PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 27, 2001 at 04:45:43PM +1100, Andrew Morton wrote:
> 2.4.1-pre10-vanilla, using read()/write():      34.5% CPU
> 2.4.1-pre10+zercopy, using read()/write():      38.1% CPU

Am I right to be bothered by this?

The majority of Unix network traffic is handled with read()/write().
Why would zerocopy slow that down?

If zerocopy is simply unoptimized, that's fine for now. But if the
problem is inherent in the implementation or design, that might be a
problem. Any patch which incurs a signifigant slowdown on traditional
networking should be contraversial.

Aaron Lehmann

please ignore me if I don't know what I'm talking about.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
