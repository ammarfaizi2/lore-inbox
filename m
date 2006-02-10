Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbWBJS5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbWBJS5H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 13:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbWBJS5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 13:57:07 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:53849 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750891AbWBJS5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 13:57:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=i21e3etg27NsA5teOehVe2PnNZZ0nOQ8z+39ufO9eLNbHI3mWDbe1lDMqs9m+uJrSFJQNfaH3+S8v6wuMkULKzQcgTuiU85ra8H38kIB327fR8RCKOiyNRf0nSpyg3y6UOz7HZ32dhFFuUUvUWvelOl3jsV4eR3yJt0yWvmQ+sk=  ;
Message-ID: <43ECE1FE.1050704@yahoo.com.au>
Date: Sat, 11 Feb 2006 05:57:02 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux@horizon.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       sct@redhat.com
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
References: <20060210172929.27423.qmail@science.horizon.com> <Pine.LNX.4.64.0602100935350.19172@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602100935350.19172@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 10 Feb 2006, linux@horizon.com wrote:
> 
>>No.  MS_ASYNC says "I need the data written now.".
> 
> 
> Says you.
> 
> I say (and I have a decade of Linux historical behaviour to back it up) 
> that is says "I'm done, start flushing this out asynchronously like all 
> the other data I have written".
> 
> And yes, there are performance implications. But your claim that "start IO 
> now" performs better is bogus. It _sometimes_ performs better, but 
> sometimes performs much worse.
> 
> Take an example. You have a 200MB dirty area in a 1GB machine. You do 
> MS_ASYNC. What do you want to happen?
> 

It quite obviously depends on the context in which one is using it,
which will depend on what one expects it to do (unless one is an idiot).

If linux@horizon.com's[1] database has dirtied 200MB of data and
knows it will not dirty it again and has several hundred ms of useful
work to do before it must call MS_SYNC, then...

> Do you want IO to be started on all of it?

... yes.

[1] Come on, linux, can you at least make up a name for me, or are
     you really called Linux? (in which case you'd better make up a
     new name anyway when arguing with Linus about Linux, for the
     sake of everyone's sanity)

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
