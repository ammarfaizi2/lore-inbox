Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316187AbSEKCFF>; Fri, 10 May 2002 22:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316192AbSEKCFE>; Fri, 10 May 2002 22:05:04 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:16591 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S316187AbSEKCFE>; Fri, 10 May 2002 22:05:04 -0400
Date: Sat, 11 May 2002 03:07:51 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BUG() disassembly tweak 
In-Reply-To: <2764.1021080847@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.21.0205110258480.2235-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 May 2002, Keith Owens wrote:
> 
> IMNSHO the instructions _after_ the oops are almost useless.

Oh, I agree: I'd be perfectly happy for ksymoops to abandon trying
to disassemble the instructions after the oops, and I don't think
it need try to disassemble the instructions before the oops either.

It is important that it show the bytes (preferably before and)
after the oops, so that an investigator can locate that sequence
of bytes in a built object; and it is important that we have some
tool (objdump) which can disassemble the built object despite ud2
and its accompanying data; but ksymoops does not need to do it.

Hugh

