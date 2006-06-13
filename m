Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWFMMYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWFMMYo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 08:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWFMMYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 08:24:44 -0400
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:122 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932082AbWFMMYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 08:24:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=c62cYCXhncJecZ4WIRomddM4PDkOYd/VeIkdU05IyEihUikGCAvxMTrLgIC0Vj/GyuBqWUyLSMOWhbRItdgt6tj9hmP3WnFcD3TaSXjwYIGFq3WP2lSQZ3BuHR9DY2Sg43vXLdfxdzfGDzL0P1O6/eAd/5DKj1OvlMeXMREcoww=  ;
Message-ID: <448EAE85.3090807@yahoo.com.au>
Date: Tue, 13 Jun 2006 22:24:37 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: Andi Kleen <ak@suse.de>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] mm: tracking shared dirty pages
References: <20060613112120.27913.71986.sendpatchset@lappy>	 <20060613112131.27913.43169.sendpatchset@lappy>	 <p73zmghqn2z.fsf@verdi.suse.de> <1150200914.20886.135.camel@lappy>
In-Reply-To: <1150200914.20886.135.camel@lappy>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:
> On Tue, 2006-06-13 at 14:03 +0200, Andi Kleen wrote:
> 
>>Peter Zijlstra <a.p.zijlstra@chello.nl> writes:
>>
>>
>>>From: Peter Zijlstra <a.p.zijlstra@chello.nl>
>>>
>>>People expressed the need to track dirty pages in shared mappings.
>>
>>Why only shared mappings? Anonymous pages can be dirty too
>>and would need to be written to swap then before making progress.
> 
> 
> Anonymous pages are per definition dirty, as they don't have a
> persistent backing store.

They can be clean.

> Each eviction of an anonymous page requires IO
> to swap space. On swap-in pages are removed from the swap space to make
> place for other pages.

No they can remain in swap too.

Swap is a bit different because the memory usage patters are going
to be much different. There is no reason why something similar couldn't
be done for swap as well, however I don't think there is so much need
for it that has been demonstrated.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
