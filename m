Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313563AbSFEIb5>; Wed, 5 Jun 2002 04:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313687AbSFEIb4>; Wed, 5 Jun 2002 04:31:56 -0400
Received: from cm16094.red.mundo-r.com ([213.60.16.94]:55204 "EHLO demo.mitica")
	by vger.kernel.org with ESMTP id <S313563AbSFEIb4>;
	Wed, 5 Jun 2002 04:31:56 -0400
To: lkml <linux-kernel@vger.kernel.org>
Subject: Problem with IDE in 2.4.19-pre10
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 05 Jun 2002 10:38:44 +0200
Message-ID: <m2n0uaunl7.fsf@demo.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi
        first of all, I am using gcc-3.1 & compiling with -Os, problem
        can be related to the compiler (trying to reproduce with and
        older compiler and -O2).

I got this backtrace:

It looks as if bh->b_end_io() got corrupt for some strange reason.
Have you had any problems with 2.4.19-pre10 running cerberus or other
heavy tests?

Later, Juan.

[1]kdb> bt                                                                      
    EBP       EIP         Function(args)                                        
0x00000001 0xc0680001 <unknown>+0xc0680001 (0xd4b7d94c, 0x1)                    
                               kernel <unknown> 0x0 0x0 0x0                     
           0xc018cea1 end_that_request_first+0x3b (0xe7dc50c4, 0x1, 0xc03b00ec) 
                               kernel .text 0xc0100000 0xc018ce66 0xc018cf1c    
           0xc019cef1 ide_end_request+0x41                                      
                               kernel .text 0xc0100000 0xc019ceb0 0xc019cf4e    
           0xc01a99a6 ide_dma_intr+0x74                                         
                               kernel .text 0xc0100000 0xc01a9932 0xc01a99ca

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
