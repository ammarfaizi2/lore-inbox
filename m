Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264643AbSJPBIV>; Tue, 15 Oct 2002 21:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264671AbSJPBIU>; Tue, 15 Oct 2002 21:08:20 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:55951 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S264643AbSJPBIU>; Tue, 15 Oct 2002 21:08:20 -0400
Message-ID: <3DACBD58.AAD8F0A@austin.ibm.com>
Date: Tue, 15 Oct 2002 20:14:00 -0500
From: Saurabh Desai <sdesai@austin.ibm.com>
Organization: IBM Corporation
X-Mailer: Mozilla 4.7 [en] (X11; U; AIX 4.3)
X-Accept-Language: en-US,en-GB
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@zip.com.au>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       NPT library mailing list <phil-list@redhat.com>
Subject: Re: [patch] mmap-speedup-2.5.42-C3
References: <Pine.LNX.4.44.0210151438440.10496-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> the attached patch (against BK-curr) adds three new, threading related
> improvements to the VM.
> 
> the first one is an mmap inefficiency that was reported by Saurabh Desai.
> The test_str02 NPTL test-utility does the following: it tests the maximum
> number of threads by creating a new thread, which thread creates a new
> thread itself, etc. It basically creates thousands of parallel threads,
> which means thousands of thread stacks.

  Like to point out, test_str02 is a NGPT test program not NPTL.

 
> the patch was tested on x86 SMP and UP. Saurabh, can you confirm that this
> patch fixes the performance problem you saw in test_str02?
> 

  Yes, the test_str02 performance improved a lot using NPTL.
  However, on a side effect, I noticed that randomly my current telnet session
  was logged out after running this test. Not sure, why?  
  I applied your patch on 2.5.42 kernel and running glibc-2.3.1pre2.
