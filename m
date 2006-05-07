Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbWEGOSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWEGOSM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 10:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWEGOSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 10:18:12 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:63919 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932171AbWEGOSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 10:18:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=TwhKJWBLLK4YdBL4AAb0QqCCFQL9AR8JDvIIWRsikNgTfvIzaSVnH5+qEhW3rtCbRYk73XbeeELY31rv/Z//Gog+h56Z1JuOKKgDXouQs38qDAFbg5pNe96iv9XRDbE9d0ps3wmKZZsAzkQiwLS+0GxDZbDPjmtiymwYyhY+0n0=  ;
Message-ID: <445DFE72.4080801@yahoo.com.au>
Date: Mon, 08 May 2006 00:04:34 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Mike Galbraith <efault@gmx.de>, Andi Kleen <ak@suse.de>,
       Christopher Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org
Subject: Re: sched_clock() uses are broken
References: <44578EB9.8050402@nortel.com> <200605021859.18948.ak@suse.de> <445791D3.9060306@yahoo.com.au> <1146640155.7526.27.camel@homer> <445DE925.9010006@yahoo.com.au> <20060507124307.GA20443@flint.arm.linux.org.uk> <445DEE70.10807@yahoo.com.au> <445DEF6D.1050902@yahoo.com.au> <20060507131825.GC20443@flint.arm.linux.org.uk> <445DF667.309@yahoo.com.au> <20060507135540.GD20443@flint.arm.linux.org.uk>
In-Reply-To: <20060507135540.GD20443@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

> Also, any comments on update_cpu_clock() and current_sched_time() both
> appearing to be buggy, or am I barking up the wrong tree with those?

Can't remember off the top of my head who put those in, sorry.

Aside from the fact that they appear to be fundamentally buggy anyway
because we don't require exact ns intervals from sched_clock() at the
best of times, I think your wrapping fix for them looks correct.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
