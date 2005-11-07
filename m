Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbVKGFtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbVKGFtZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 00:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbVKGFtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 00:49:25 -0500
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:53099 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S964780AbVKGFtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 00:49:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=qcEBh5TIRFIvW3rxJ4KFHqoAVuCN8S9r8JC6Cf9AJBvsyWjvHlMqs4+Yuw8OVF3FXP5DMpeM/A5QThwomCo0HgOMUtUn8J8HehzgESXKbKHmJcwIbiIf/udeqaxe938UnZFmAuTjExCjLk3wF61ZxeQXU+ABT5MiXcxkI8dCcaA=  ;
Message-ID: <436EEB5E.5020704@yahoo.com.au>
Date: Mon, 07 Nov 2005 16:51:26 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: paulmck@us.ibm.com
CC: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, oleg@tv-sign.ru, dipankar@in.ibm.com,
       suzannew@cs.pdx.edu
Subject: Re: [PATCH] Fixes for RCU handling of task_struct
References: <20051031020535.GA46@us.ibm.com> <20051031140459.GA5664@elte.hu> <20051106134945.0e10cb60.akpm@osdl.org> <436EA9F9.4020809@yahoo.com.au> <20051107045809.GA24195@us.ibm.com>
In-Reply-To: <20051107045809.GA24195@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul E. McKenney wrote:
> On Mon, Nov 07, 2005 at 12:12:25PM +1100, Nick Piggin wrote:

>>Yes, it is basically ready to go.
> 
> 
> Would it simplify the rcuref.h code?  Or lib/dec_and_lock.c?
> 

Yep, I recently posted it to lkml... rcuref.h disappears, and
dec_and_lock becomes simplified not to mention more efficient
on those architectures which do not define HAVE_ARCH_CMPXCHG.

http://marc.theaimsgroup.com/?l=linux-kernel&m=113117753625350&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=113117753629218&w=2

I need the infrastructure for lockless pagecache, but fortunately
it is very useful for other things as well. Especially lockless
algorithms it seems.

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
