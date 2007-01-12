Return-Path: <linux-kernel-owner+w=401wt.eu-S1751517AbXALAHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbXALAHR (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 19:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbXALAHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 19:07:17 -0500
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:32148 "HELO
	smtp110.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751517AbXALAHP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 19:07:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=EvhubOlucxpGl303KggN+6hGYeFk6XxhkKBmb3j22H2/TYo8J3iM36dx5A8ApqPFTVHupPhDEq3RUmnzVNmgi1aFl5Pi4T0rrBelpHboOIE6fvI+/wMKHgZVy+H5i6GuWiLgJBnVJQqDM7+PyiI6GoMbEANA5LZ/N/g4d6JqGJE=  ;
X-YMail-OSG: _mQ5jS8VM1kUfrkbkNhy6KOGYiT0xnDzwGwRaeIjc3Y8.ngXeizCqI6JLRnLHLxqXVj7gev6njq.jJshF8fSgbqU4IkQiIHnprSXiBd5c.hDL6k33UwYNJFiKZ06d7JVfwOe_kQwtVqi0p4-
Message-ID: <45A6D118.5030508@yahoo.com.au>
Date: Fri, 12 Jan 2007 11:06:48 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: David Chinner <dgc@sgi.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [REGRESSION] 2.6.19/2.6.20-rc3 buffered write slowdown
References: <20070110223731.GC44411608@melbourne.sgi.com> <Pine.LNX.4.64.0701101503310.22578@schroedinger.engr.sgi.com> <20070110230855.GF44411608@melbourne.sgi.com> <45A57333.6060904@yahoo.com.au> <20070111003158.GT33919298@melbourne.sgi.com> <45A58DFA.8050304@yahoo.com.au> <20070111012404.GW33919298@melbourne.sgi.com> <45A602F0.1090405@yahoo.com.au> <Pine.LNX.4.64.0701110950380.28802@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0701110950380.28802@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Thu, 11 Jan 2007, Nick Piggin wrote:
> 
> 
>>You're not turning on zone_reclaim, by any chance, are you?
> 
> 
> It is not a NUMA system so zone reclaim is not available.

Ah yes... Can't you force it on if you have a NUMA complied kernel?

> zone reclaim was 
> already in 2.6.16.

Well it was a long shot, but that is something that has had a few
changes recently and is something that could interact badly with
the global pdflush.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
