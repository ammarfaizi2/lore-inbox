Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWBZMak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWBZMak (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 07:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWBZMak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 07:30:40 -0500
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:11443 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750761AbWBZMaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 07:30:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=HE+2elB42gLefEDYpjqD31BBi97qKmjT6gKDnCwkLfTukE76gw+1kzXQD2UlL0NS7LwJcq/z+OmNsjuowIC3gLR328I2/UOdnIcH6KTlcwJ4s//SbkwT79uwHncClHoOlQS52GppF4Qde54VOVWhSdx5R2F579PFBqKlbudEP3g=  ;
Message-ID: <44019F6C.4020400@yahoo.com.au>
Date: Sun, 26 Feb 2006 23:30:36 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
CC: Victor Porton <porton@ex-code.com>, Avi Kivity <avi@argo.co.il>,
       linux-kernel@vger.kernel.org, Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: New reliability technique
References: <4400B562.6020203@argo.co.il> <E1FDKB1-0001GK-00@porton.narod.ru> <84144f020602260425p70fc4c5cn6de8dd6aa8a876d7@mail.gmail.com>
In-Reply-To: <84144f020602260425p70fc4c5cn6de8dd6aa8a876d7@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:
> On 2/26/06, Victor Porton <porton@ex-code.com> wrote:
> 
>>Isn't it better to double check (especially after such risky things as
>>e.g. software suspend)?
>>
>>We need to check not only for damaged hardware, but also for
>>kernel/modules bugs. For this ECC and cache reliability is useless.
> 
> 
> What kernel bugs do you want to catch with double-checking free
> memory? For use-after-free, we already have slab poisoning.
> 

And for !slab, we unmap kernel virtual addresses with page debugging,
which seems like a better solution.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
