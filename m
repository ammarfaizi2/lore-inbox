Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422630AbWBOIGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422630AbWBOIGW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 03:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423029AbWBOIGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 03:06:22 -0500
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:45151 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422630AbWBOIGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 03:06:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=dawG30D1lkUv7sPkxgFX+UCnm39hWg+Pl+84TZJ42QekgMiqG00JbfmpM9uQQK0FBP+dvtbUWHZZUJMx79xV4IZHw92pHEFOtBiUrTd1qANRU6A3IeORbfguvD4PYkl+ymWwGLCjWaReFslp/cgOxyVtttR9S1+gH6DUcFZ8oGE=  ;
Message-ID: <43F2D30F.9050904@yahoo.com.au>
Date: Wed, 15 Feb 2006 18:06:55 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Gleb Natapov <gleb@minantech.com>
CC: Roland Dreier <rdreier@cisco.com>, Andrew Morton <akpm@osdl.org>,
       mst@mellanox.co.il, hugh@veritas.com, wli@holomorphy.com,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org, vandrove@vc.cvut.cz, pbadari@us.ibm.com,
       grundler@parisc-linux.org, matthew@wil.cx
Subject: Re: [PATCH] Fix up MADV_DONTFORK/MADV_DOFORK definitions
References: <20060213210906.GC13603@mellanox.co.il> <Pine.LNX.4.61.0602132157110.3761@goblin.wat.veritas.com> <Pine.LNX.4.64.0602131426470.3691@g5.osdl.org> <20060213225538.GE13603@mellanox.co.il> <Pine.LNX.4.61.0602132259450.4627@goblin.wat.veritas.com> <20060213233517.GG13603@mellanox.co.il> <43F2AEAE.5010700@yahoo.com.au> <adawtfxqhk1.fsf@cisco.com> <20060214221654.67288424.akpm@osdl.org> <adaslqlqgdz.fsf_-_@cisco.com> <20060215064836.GG24524@minantech.com>
In-Reply-To: <20060215064836.GG24524@minantech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gleb Natapov wrote:
> On Tue, Feb 14, 2006 at 10:34:48PM -0800, Roland Dreier wrote:
> 
>>    Andrew> yes, please do.
>>
>>OK, here's a patch that changes them to 9 and 10.  I would hold off
>>sending this to Linus until Michael has a chance to speak up, in case
>>there's a reason I don't know for choosing 0x30 and 0x31.
>>
> 
> Here
> http://marc.theaimsgroup.com/?l=linux-kernel&m=113162971606408&w=2
> at the end there is a reasoning.

Well it may make userspace portability slightly easier for this
one case (exactly how, I'm not so sure because each architecture
has their own MADV_ defines anyway). I rather think this should
be left up to arch maintainers' numbering schemes, but...

> So I think 9 and 10 will do too.

s/too// ?

0x30 and 0x31 broke parisc's numbering scheme.

> By the way Nick was on CC list back than and haven't raised any 
> concerns :)
> 

I probably would have assumed it had gone past arch maintainers
and so wouldn't have given it a second thought: I don't know a
great deal about the issues here. I just now happened to see the
parisc comment.

But no harm done this time.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
