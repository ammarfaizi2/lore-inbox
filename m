Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266081AbUAVQDR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 11:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266249AbUAVQDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 11:03:16 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52895 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266081AbUAVQDN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 11:03:13 -0500
Message-ID: <400FF433.2010906@pobox.com>
Date: Thu, 22 Jan 2004 11:02:59 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: ncunningham@users.sourceforge.net, john@grabjohn.com,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: Shutdown IDE before powering off.
References: <1074735774.31963.82.camel@laptop-linux>	<20040121234956.557d8a40.akpm@osdl.org>	<200401220813.i0M8DX4Q000511@81-2-122-30.bradfords.org.uk>	<1074759964.12536.65.camel@laptop-linux> <20040122004554.26536158.akpm@osdl.org>
In-Reply-To: <20040122004554.26536158.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nigel Cunningham <ncunningham@users.sourceforge.net> wrote:
> 
>>Hi.
>>
>>On Thu, 2004-01-22 at 21:13, John Bradford wrote:
>>
>>>>This spins down the disk(s) when you're just doing do a reboot.  That's
>>>>fairly irritating and could affect reboot times if one has many disks.
>>>
>>>I think it is an attempt to force some broken drives to flush their
>>>cache, but I wonder whether it will simply move the problem from one
>>>set of broken drives to another :-).
>>
>>Yes, they were trying to get caches flushed. If this attempt is
>>misguided, that's fine. Is there a better way?
> 
> 
> A couple of thoughts come to mind:
> 
> a) Don't do it if the user typed reboot - only do it if we're powering down.
> 
> b) Try to do a cache flush instead.  If that fails (do we know?) then
>    power down the disk instead.


I'm either shock or very very worried that the reboot notifier that 
flushes IDE in 2.4.x, ide_notifier, is nowhere to be seen in 2.6.x :( 
That seems like the real problem -- the code _used_ to be there.

	Jeff



