Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750960AbWHIB6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbWHIB6b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 21:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWHIB6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 21:58:31 -0400
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:43104 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750960AbWHIB6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 21:58:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=R0ruYKqqMarLpYlpSeGRpqA/nvr1NtTiDXMgw6MAsZz2jnq6L1EW+Mf5bCnGSKf7B1i8GBFQ3LP2BcWJan0sTHS9cd81rXRQDyexXQsveb5f31GCyLg9V8UynluPumlwZMgfg5lRK5Bw+hB7/yqObe52twgbMTbAt+hqYG/s/nc=  ;
Message-ID: <44D94142.3050703@yahoo.com.au>
Date: Wed, 09 Aug 2006 11:58:26 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060216 Debian/1.7.12-1.1ubuntu2
X-Accept-Language: en
MIME-Version: 1.0
To: Ulrich Drepper <drepper@gmail.com>
CC: Eric Dumazet <dada1@cosmosbay.com>, Andi Kleen <ak@suse.de>,
       Ravikiran G Thirumalai <kiran@scalex86.org>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       pravin b shelar <pravin.shelar@calsoftinc.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] NUMA futex hashing
References: <20060808070708.GA3931@localhost.localdomain>	 <a36005b50608080739w2ea03ea8i8ef2f81c7bd55b5d@mail.gmail.com>	 <44D8A9BE.3050607@yahoo.com.au>	 <200608081808.34708.dada1@cosmosbay.com> <a36005b50608080958n192e9324jb9d5a7a59b365eae@mail.gmail.com>
In-Reply-To: <a36005b50608080958n192e9324jb9d5a7a59b365eae@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:

>> Of course we would need a new syscall, and to change glibc to be able to
>> actually use this new private_futex syscall.
>
>
> No, why?  The kernel already does recognize private mutexes.  It just
> checks whether the pages used to store it are private or mapped.  This
> requires some interaction with the memory subsystem but as long as no
> crashes happen the data can change underneath.  It's the program's
> fault if it does.


Because that requires taking mmap_sem. Avoiding that is the whole
purpose, isn't it?

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
