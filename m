Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030186AbWHXPyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbWHXPyQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 11:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964997AbWHXPyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 11:54:16 -0400
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:52138 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751611AbWHXPyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 11:54:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=E6ByiUpL5I2MI5iTeXeTYFnJb2dbpi/HL1o2Haug4XDOn9yeCuOe9YUSYQrEM5ppZIHyQTtS02BpwjBda/FqJg3aUP6wtvFD1p1Vklm2XtJhvJ8NG/JCHhtxyxt7ZvbeVcgUc0IJPOmB5+fS89AHNRD/jTemHmbj3vF+7L+hqNk=  ;
Message-ID: <44EDCB83.3010500@yahoo.com.au>
Date: Fri, 25 Aug 2006 01:53:39 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Arjan van de Ven <arjan@infradead.org>, ego@in.ibm.com,
       rusty@rustcorp.com.au, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, arjan@intel.linux.com, davej@redhat.com,
       dipankar@in.ibm.com, vatsa@in.ibm.com, ashok.raj@intel.com
Subject: Re: [RFC][PATCH 4/4] Rename lock_cpu_hotplug/unlock_cpu_hotplug
References: <20060824103417.GE2395@in.ibm.com> <1156417200.3014.54.camel@laptopd505.fenrus.org> <20060824140342.GI2395@in.ibm.com> <1156429015.3014.68.camel@laptopd505.fenrus.org> <44EDBDDE.7070203@yahoo.com.au> <20060824150026.GA14853@elte.hu>
In-Reply-To: <20060824150026.GA14853@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>It really is just like a reentrant rw semaphore... I don't see the 
>>point of the name change, but I guess we don't like reentrant locks so 
>>calling it something else might go down better with Linus ;)
> 
> 
> what would fit best is a per-cpu scalable (on the read-side) 
> self-reentrant rw mutex. We are doing cpu hotplug locking in things like 
> fork or the slab code, while most boxes will do a CPU hotplug event only 
> once in the kernel's lifetime (during bootup), so a classic global 
> read-write lock is unjustified.

I agree with you completely.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
