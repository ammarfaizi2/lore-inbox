Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275004AbRJAMqN>; Mon, 1 Oct 2001 08:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275006AbRJAMqD>; Mon, 1 Oct 2001 08:46:03 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:50094
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S275004AbRJAMqC>; Mon, 1 Oct 2001 08:46:02 -0400
Date: Mon, 01 Oct 2001 08:41:40 -0400
From: Chris Mason <mason@suse.com>
To: Mikael Pettersson <mikpe@csd.uu.se>, torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.11-pre1 oops in bdget()
Message-ID: <1262100000.1001940100@tiny>
In-Reply-To: <200110010002.CAA14944@harpo.it.uu.se>
In-Reply-To: <200110010002.CAA14944@harpo.it.uu.se>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday, October 01, 2001 02:02:23 AM +0200 Mikael Pettersson
<mikpe@csd.uu.se> wrote:

> Running 2.4.11-pre1 built with gcc 2.95.3, building 2.4.10-ac1,
> final dd in 'make bzdisk' oopsed with the following:

> Unable to handle kernel paging request at virtual address d08b8b60
> c0133664
> *pde = 0fd41067
> Oops: 0000
> CPU:    0
> EIP:    0010:[<c0133664>]
 
>>> EIP; c0133664 <bdget+f8/180>   <=====
> Trace; c0133792 <bd_acquire+26/80>
> Trace; c0133c16 <blkdev_open+16/b8>

Well, this isn't good, looks like we've already freed something and are
still using it.  Could you please turn on 'Debug memory allocations' in the
kernel debugging section of make config, and try to reproduce again?

-chris

