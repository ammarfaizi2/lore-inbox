Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314481AbSDRWjc>; Thu, 18 Apr 2002 18:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314483AbSDRWjb>; Thu, 18 Apr 2002 18:39:31 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:21769 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S314481AbSDRWja>; Thu, 18 Apr 2002 18:39:30 -0400
Message-ID: <3CBF4B13.38B20491@zip.com.au>
Date: Thu, 18 Apr 2002 15:39:15 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel BUG in ext3 (2.4.18pre1)
In-Reply-To: <5.1.0.14.0.20020418230637.0164d828@mailhost.ivimey.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ruth Ivimey-Cook wrote:
> 
> ...
> Apr 17 23:20:01 gatemaster kernel: Assertion failure in
> __journal_file_buffer() at transaction.c:1935: "jh->b_jlist < 9"
> Apr 17 23:20:01 gatemaster kernel: kernel BUG at transaction.c:1935!

That's the first time this has been reported.  Conceivably,
ext3 has corrupted the journal_head.  More conceivably, some
other part of the kernel scribbled on it.  Most conceivably,
your memory flipped a bit.

Best I can suggest is that you give the machine an overnight
run with memtest86.

-
