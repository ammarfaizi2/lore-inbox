Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752070AbWCHHlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070AbWCHHlg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 02:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752089AbWCHHlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 02:41:36 -0500
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:21437 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751120AbWCHHlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 02:41:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=AEDZwj3eFq3FyqGnIwweTByXTcWp6LpQyRmVLbdR+8oIFEVI0bcLfY2mZeXTGqAa90nPPcOiHrVBWr3hLoF5U+zeC7B7xYUSqMUbh/i3C88vllzcdyKDJgzCNr/FFMHVNdf4BYlwsU8UdfCJBTTVeef0ghH/kpT4eYWEgxZEMKg=  ;
Message-ID: <440E8AAA.9030609@yahoo.com.au>
Date: Wed, 08 Mar 2006 18:41:30 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
CC: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       mingo@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers
References: <31492.1141753245@warthog.cambridge.redhat.com> <17422.19209.60360.178668@cargo.ozlabs.ibm.com>
In-Reply-To: <17422.19209.60360.178668@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras wrote:
> David Howells writes:

>>+     The way to deal with this is to insert an I/O memory barrier between the
>>+     two accesses:
>>+
>>+	*ADR = ctl_reg_3;
>>+	mb();
>>+	reg = *DATA;
> 
> 
> Ummm, this implies mb() is "an I/O memory barrier".  I can see people
> getting confused if they read this and then see mb() being used when
> no I/O is being done.
> 

Isn't it? Why wouldn't you just use smp_mb() if no IO is being done?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
