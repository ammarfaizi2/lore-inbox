Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270858AbRHNVBd>; Tue, 14 Aug 2001 17:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270843AbRHNVBY>; Tue, 14 Aug 2001 17:01:24 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:5644 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S270841AbRHNVBQ>; Tue, 14 Aug 2001 17:01:16 -0400
Message-ID: <3B79919F.131ACAE6@zip.com.au>
Date: Tue, 14 Aug 2001 14:01:19 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8-ac4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: J Troy Piper <jtp@dok.org>
CC: linux-kernel@vger.kernel.org, ext3-users@redhat.com
Subject: Re: [BUG] linux-2.4.7-ac7 Assertion failure in journal_revoke() at 
 revoke.c:307
In-Reply-To: <20010814153255.A1377@dok.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J Troy Piper wrote:
> 
> Greetings all,
> 
> I have hit a kernel BUG in revoke.c in kernel 2.4.7-ac7 twice today while
> attempting to perform the same operation (patching stock 2.4.8 kernel src
> with "patch -p1 <  patch-2.4.8-ac4").  Syslog entries follow.  Please
> email me if you want/need my kernel config or any other information.
> 

If possible, could you please use kernel 2.4.8 with the patch
http://www.zip.com.au/~akpm/ext3-2.4-0.9.6-248.gz applied?

Enable buffer tracing in config.  If it happens again, we'll
get lots of nice info which will tell us what happened.

Also, please run `e2fsck -f' against the affected filesystem - if
it's already in an incorrect state ext3 perhaps could have become
confused.

Thanks.
