Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750855AbVLGLMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbVLGLMt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 06:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbVLGLMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 06:12:49 -0500
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:40800 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750853AbVLGLMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 06:12:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=4JCjQFMUtkYIm33QmYyvVkiYkf12deEPRM5G5vQsa5DQfa+m/lUDhvKzUhArch8Tv3AsAqSSCpkFgpsq2C/o6tNJyPhjmVcECQngL19xIfYGyAyAzAuVfHYGLdrQNkG06JDodvucq6yw6SD3g9g6G+tYHfSODfjeszl6b55HGdE=  ;
Message-ID: <4396C3AC.9000802@yahoo.com.au>
Date: Wed, 07 Dec 2005 22:12:44 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <christoph@lameter.com>,
       Rik van Riel <riel@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Magnus Damm <magnus.damm@gmail.com>, Nick Piggin <npiggin@suse.de>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH 12/16] mm: fold sc.may_writepage and sc.may_swap into
 sc.flags
References: <20051207104755.177435000@localhost.localdomain> <20051207105154.142779000@localhost.localdomain> <4396BB27.50104@yahoo.com.au> <20051207111117.GA8001@mail.ustc.edu.cn>
In-Reply-To: <20051207111117.GA8001@mail.ustc.edu.cn>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang wrote:
> On Wed, Dec 07, 2005 at 09:36:23PM +1100, Nick Piggin wrote:
> 
>>Wu Fengguang wrote:
>>
>>>Fold bool values into flags to make struct scan_control more compact.
>>>
>>
>>Probably not a bad idea (although you haven't done anything for 64-bit
>>archs, yet)... do we wait until one more flag wants to be added?
> 
> 
> I did this to hold some more debug flags :)

Yes, but if they make sense for the current kernel too, it reduces
the peripheral noise out of your patchset... which helps everyone :)

> I'll make it a standalone patch, too.
> 

Thanks. I don't have strong feelings either way, but I had always
been meaning to do something like this if we picked up another flag.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
