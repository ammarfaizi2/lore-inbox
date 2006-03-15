Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752104AbWCOBZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104AbWCOBZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 20:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752112AbWCOBZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 20:25:27 -0500
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:45995 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1752104AbWCOBZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 20:25:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=reLp/y4eQHFozRiPB44LmP88v7uKGT4s3QSIgV8iym64ZHz+BDdcaZzCtt8tyU69JlUTlodO4Wew1mJzxuo5WlhohrZ032rfU+28om1Oq3v1LaQVwxdMHIw5zzQT2M4U2MbinCcVYclPxU+L+FkCH8d4pzfzp8w2wCezECmsvco=  ;
Message-ID: <44176CF9.90909@yahoo.com.au>
Date: Wed, 15 Mar 2006 12:25:13 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: David Howells <dhowells@redhat.com>, Paul Mackerras <paulus@samba.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, akpm@osdl.org,
       linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
       mingo@redhat.com, alan@redhat.com, linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #4]
References: <17431.14867.211423.851470@cargo.ozlabs.ibm.com>  <m1veujy47r.fsf@ebiederm.dsl.xmission.com> <16835.1141936162@warthog.cambridge.redhat.com> <32068.1142371612@warthog.cambridge.redhat.com>  <2301.1142380768@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0603141609520.3618@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603141609520.3618@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>
>On Tue, 14 Mar 2006, David Howells wrote:
>
>>But that doesn't make any sense!
>>
>>That would mean we that we'd've read b into d before having read the new value
>>of p into q, and thus before having calculated the address from which to read d
>>(ie: &b) - so how could we know we were supposed to read d from b and not from
>>a without first having read p?
>>
>>Unless, of course, the smp_wmb() isn't effective, and the write to b happens
>>after the write to p; or the Alpha's cache isn't fully coherent.
>>
>
>The cache is fully coherent, but the coherency isn't _ordered_.
>
>

This is what I was referring to when I said your (David's) idea of "memory"
WRT memory consistency isn't correct -- cache coherency can be out of order.

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
