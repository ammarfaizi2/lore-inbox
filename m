Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031886AbWLGJhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031886AbWLGJhK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 04:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031892AbWLGJhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 04:37:10 -0500
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:24207 "HELO
	smtp105.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1031886AbWLGJhI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 04:37:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=F+qDXei2rjcqioVj3YPB5m5nXqA57pefg1Ftv6CPY1R8h3IisNPQmkx/2BrecCHjP6HtrcOhydesAtufhL0iJqWERIy8c1WfIoqDNsURbQanDoWdxmy7EqYSQLyWmKCvMQcluDxE/+og7g+/6DegZ5ggXpAJN0DHiXZ5kn53D0c=  ;
X-YMail-OSG: UunFxfIVM1nadQNRu4A3iwY8bcNBu_4scnM4Z75j3AElao51.B8PMHXrgMB6VDGdCbjinw5Q9GjsgkIWQreHgxcXxuk2dKUk0iJXiMLE5nKh.aq4_yujjJgEfYkieudO1a7gvDOzrT2fxEY-
Message-ID: <4577E095.1040904@yahoo.com.au>
Date: Thu, 07 Dec 2006 20:36:21 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: Larry Finger <Larry.Finger@lwfinger.net>, Andrew Morton <akpm@osdl.org>,
       Benoit Boissinot <bboissin@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc5-mm1 progression
References: <456718F6.8040902@lwfinger.net>	 <40f323d00611240836q6bcf7374gd47c7a97d1d4f8e3@mail.gmail.com>	 <20061125112437.3d46eff4.akpm@osdl.org>  <4574E86B.10403@lwfinger.net> <1165407170.12561.12.camel@twins>
In-Reply-To: <1165407170.12561.12.camel@twins>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:
> On Mon, 2006-12-04 at 21:32 -0600, Larry Finger wrote:

>>There are at least two patches in 2.6.19-rc5-mm2 that make my system much more responsive for 
>>interactive jobs. The one that has the majority of the effect is:
>>
>>radix-tree-rcu-lockless-readside.patch
>>
>>I have not been able to isolate the second patch, which has the lesser effect. All I can say is that 
>>it occurred before the above patch in patches/series. This patch was tested against 2.6.19 and fixed 
>>most of the problem on that version.
> 
> 
> Curious...
> 
> This patch introduces the direct pointer optimisation for single element
> radix trees and makes the radix tree safe to read in a lock-less manner
> which is not used -yet-. The only difference that that should have is
> that the elements are freed using rcu callback instead of directly.
> 
> /me puzzled how this has a large effect on interactivity.
> 
> Nick?

I have already got the direct data optimisation upstream. It might be
possible that it is some interaction with the extra rcu callbacks going
off... I don't know :\

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
