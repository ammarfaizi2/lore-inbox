Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316880AbSGRHlz>; Thu, 18 Jul 2002 03:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317169AbSGRHlz>; Thu, 18 Jul 2002 03:41:55 -0400
Received: from holomorphy.com ([66.224.33.161]:49033 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316880AbSGRHly>;
	Thu, 18 Jul 2002 03:41:54 -0400
Date: Thu, 18 Jul 2002 00:44:21 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>, sfr@canb.auug.org.au
Subject: Re: [PATCH] Initcall depends automagic
Message-ID: <20020718074421.GN1096@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	sfr@canb.auug.org.au
References: <20020718073932.D82A04164@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020718073932.D82A04164@lists.samba.org>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 05:36:09PM +1000, Rusty Russell wrote:
> This patch generates initcall ordering based on the theory that if A.o
> references a symbol in B.o, then B.o's initcall must preceed A.o's.
> Kai and I came up with the approach, and Stephen Rothwell did all the
> implementation brain sweat.  I did the typing.
> Unfortunately, there are dependency loops in the kernel which make
> this approach fail, but if someone wants to play with it and try to
> untangle them, they are more than welcome.  One option would be to
> look at more course-grained .o files, rather than *all* .o files
> (eg. fs/ext2/ext2.o rather than fs/ext2/*.o).
> I will be persuing my previous explicit initcall depends patch in the
> meantime, as it offers an elegent solution that works now.

Any chance you can post the strongly connected components of the
dependency graph?


Thanks,
Bill
