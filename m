Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbVLGLlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbVLGLlA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 06:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbVLGLlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 06:41:00 -0500
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:43614 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750868AbVLGLk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 06:40:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=nyTUnjfByVwGGsmBp72BGVGX8Mhh4O+/YaCfEyufkhH7Ja3bo9jHuYo+yyl6ukXV7P1sWEllj+tEIZPmMPshV15w/iG95WTGwfvaIDhVQi0p1g4VVkzw8V1ked4yefiXqjgV2GdSG2+f3xTyGN7TByf6W8k2qcaL6hbyL9sH/Q0=  ;
Message-ID: <4396CA48.5010706@yahoo.com.au>
Date: Wed, 07 Dec 2005 22:40:56 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de, zippel@linux-m68k.org,
       linux-kernel@vger.kernel.org, rostedt@goodmis.org, johnstul@us.ibm.com
Subject: Re: [patch 00/21] hrtimer - High-resolution timer subsystem
References: <20051206000126.589223000@tglx.tec.linutronix.de> <Pine.LNX.4.61.0512061628050.1610@scrub.home> <1133908082.16302.93.camel@tglx.tec.linutronix.de> <20051207013122.3f514718.akpm@osdl.org> <20051207101137.GA25796@elte.hu> <4396B81E.4030605@yahoo.com.au> <20051207104900.GA26877@elte.hu> <4396C2EB.1000203@yahoo.com.au> <20051207113324.GA28646@elte.hu>
In-Reply-To: <20051207113324.GA28646@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 

>>Maybe it is that timeout is an end result, but timer is a mechanism.  
> 
> 
> hm, i think you are right.
> 
> 
>>So maybe it should be 'struct interval', 'struct timeout'; or 'struct 
>>timer', 'struct timeout_timer'.
> 
> 
> maybe 'struct timer' and 'struct hrtimer' is the right solution after 
> all, and our latest queue doing 'struct timer_list' + 'struct hrtimer' 
> is actually quite close to it.
> 
> 'struct ptimer' does have a bit of vagueness in it at first sight, do 
> you agree with that? (does it mean 'process'? 'posix'? 'precision'?) 
> 

Yes I would agree that the p doesn't add much, wheras hrtimer at least
*rules out* the obvious process and posix.

I can't see a problem with timer and hrtimer myself.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
