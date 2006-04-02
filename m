Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbWDBO3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbWDBO3q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 10:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWDBO3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 10:29:46 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:31378 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932339AbWDBO3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 10:29:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=X/nRTOsTM/fvgwjBwc6gxjgI4O2ZRs4yf6WhHeIyrnC3bZoLx/TcIKXcKnH0NMFVf6z5gcKlne62NBLwa9jSrSArstvdWArUs1/WebGo5kFNFLaiFLobGwHaRI/hWAeuRse6MjJzvrTmuVvEuhhM6TokhpmVGVXq8S/iUBtpZkg=  ;
Message-ID: <442F9E91.1020306@yahoo.com.au>
Date: Sun, 02 Apr 2006 19:51:13 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: ck@vds.kolivas.org, Andrew Morton <akpm@osdl.org>,
       linux list <linux-kernel@vger.kernel.org>
Subject: Re: [ck] Re: 2.6.16-ck3
References: <200604021401.13331.kernel@kolivas.org> <442F5721.2040906@yahoo.com.au> <200604021851.39763.kernel@kolivas.org> <200604021939.21729.kernel@kolivas.org>
In-Reply-To: <200604021939.21729.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

> Ok I can't see what I'm doing wrong.
> 
> here are my watermarks
> 
> idx = zone_idx(z);
> ns->lowfree[idx] = z->pages_high * 3 + z->lowmem_reserve[idx];
> ns->highfree[idx] = ns->lowfree[idx] + z->pages_high;
> 
> It's (3 * pages_high) +lowmem_reserve which is well in excess of the reserve 
> so I can't see any problem. Am I missing something?
> 

That zone->lowmem_reserve[zone_idx(zone)] == 0 ?

;)

lowmem_reserve could be much bigger than zone->high*3, when higher
zones are much larger.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
