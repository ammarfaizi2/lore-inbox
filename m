Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965252AbVINRQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965252AbVINRQi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 13:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965253AbVINRQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 13:16:38 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:45163 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S965252AbVINRQh (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Wed, 14 Sep 2005 13:16:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=grkYYhA4T4XznNYWRvd/Fw9JeFSPYji5xgAOq94WGijLRguN2yRu2vsryMWND0tFFrzOpiQKQx+hsPwfkeU3gPac+KiZVwjuaZ9XUkZUOkIWz7P70fD4JElGsJeyoNP6onpjenz8r6W6+jqmG3KbpnvjVPfLuWz6LesuKOCEYxI=  ;
Message-ID: <43285538.1090709@yahoo.com.au>
Date: Thu, 15 Sep 2005 02:52:08 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: Linux-Kernel@vger.kernel.org, dipankar@in.ibm.com
Subject: Re: [PATCH 4/5] atomic: dec_and_lock use cmpxchg
References: <4328387E.6050701@yahoo.com.au>	<432838E8.5030302@yahoo.com.au>	<432839F1.5020907@yahoo.com.au> <20050914.092441.87955714.davem@davemloft.net>
In-Reply-To: <20050914.092441.87955714.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

> I talked to Linus about my patch and he made the good point that the
> Alpha optimization is very valid (it avoids loading the GP and other
> stuff by doing that fancy assembler entry point).  So we decided that
> we'd make the cmpxchg() generic version, but make moving over to that
> gradual instead of mandatorily forcing everyone to use the new thing.
> 
> So, for example, we'd convert sparc64 (because I want to) and the
> architectures using the exact same ppc64 C code, but leave the others
> alone.  It'd be up to the remaining platform's maintainers to move
> over if they wanted to.
> 
> I'll submit that updated patch to him later today.
> 

OK that's fair enough. I'll submit whatever cleanups are possible
on top of your patch after the atomic_cmpxchg patch goes in (if
it goes in). Thanks.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
