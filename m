Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbVHYAOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbVHYAOY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 20:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbVHYAOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 20:14:24 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:25493 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932404AbVHYAOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 20:14:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=0wzVYFDVnAmQvI/tW+QAl5dkQKeKPVuJLsCUrh5VF6lpjP2JCzy2XGDRe086Zv+wCf4jeKa+WuGLRtaqtNp4meCHtxE+i07tlyGHC/zrcHYxA1jR0drDmk1pGToRFcXonw0uXqnFAE9Vqb2fNgppU60wa7/yGUWhTmE9KxavLKc=  ;
Message-ID: <430D0D6B.100@yahoo.com.au>
Date: Thu, 25 Aug 2005 10:14:35 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ray Fucillo <fucillo@intersystems.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: process creation time increases linearly with shmem
References: <430CBFD1.7020101@intersystems.com>
In-Reply-To: <430CBFD1.7020101@intersystems.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ray Fucillo wrote:
> I am seeing process creation time increase linearly with the size of the 
> shared memory segment that the parent touches.  The attached forktest.c 
> is a very simple user program that illustrates this behavior, which I 
> have tested on various kernel versions from 2.4 through 2.6.  Is this a 
> known issue, and is it solvable?
> 

fork() can be changed so as not to set up page tables for
MAP_SHARED mappings. I think that has other tradeoffs like
initially causing several unavoidable faults reading
libraries and program text.

What kind of application are you using?

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
