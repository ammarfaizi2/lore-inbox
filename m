Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267902AbTBLWch>; Wed, 12 Feb 2003 17:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267907AbTBLWch>; Wed, 12 Feb 2003 17:32:37 -0500
Received: from tapu.f00f.org ([202.49.232.129]:54976 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S267902AbTBLWcg>;
	Wed, 12 Feb 2003 17:32:36 -0500
Date: Wed, 12 Feb 2003 14:42:26 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Bruno Diniz de Paula <diniz@cs.rutgers.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: O_DIRECT foolish question
Message-ID: <20030212224226.GA13129@f00f.org>
References: <1045084764.4767.76.camel@urca.rutgers.edu> <20030212140338.6027fd94.akpm@digeo.com> <1045088991.4767.85.camel@urca.rutgers.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1045088991.4767.85.camel@urca.rutgers.edu>
User-Agent: Mutt/1.3.28i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2003 at 05:29:52PM -0500, Bruno Diniz de Paula wrote:

> But I am using multiples of page size in both buffer alignment and
> buffer size (2nd and 3rd parameters of read).  The issue is that
> when I try to read files with sizes that are NOT multiples of block
> size (and therefore also not multiples of page size), the read
> syscall returns 0, with no errors.

What filesystem?

Can you send an strace of this occurring?

> So the question remains, am I able to read just files whose size is
> a multiple of block size?

No.

You ideally should be able to read any length file with O_DIRECT.
Even a 1-byte file.



  --cw
