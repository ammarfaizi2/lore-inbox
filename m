Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbULTMaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbULTMaK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 07:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbULTMaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 07:30:10 -0500
Received: from mail07.syd.optusnet.com.au ([211.29.132.188]:12422 "EHLO
	mail07.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261496AbULTMaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 07:30:01 -0500
References: <1329986.1103525472726.JavaMail.tomcat@pne-ps1-sn1> <20041219231250.457deb12.akpm@osdl.org> <41C682F1.20200@yahoo.com.au> <200412200706.06534.edt@aei.ca>
Message-ID: <cone.1103545745.935101.4585.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Ed Tomlinson <edt@aei.ca>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       lista4@comhem.se, linux-kernel@vger.kernel.org, mr@ramendik.ru,
       kernel@kolivas.org, riel@redhat.com
Subject: Re: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
Date: Mon, 20 Dec 2004 23:29:05 +1100
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson writes:

> On Monday 20 December 2004 02:44, Nick Piggin wrote:
>> Andrew Morton wrote:
>> > Voluspa <lista4@comhem.se> wrote:
>> > 
>> >>Would be nice though if someone else could verify...
>> > 
>> > 
>> > Well I'd love to, but afaik the only workloads which we currently know of
>> > involve complex userspace apps which I have no experience running.
>> > 
>> > Did anyone come up with a simple step-by-step procedure for reproducing the
>> > problem?  It would be good if someone could do this, because I don't think
>> > we understand the root cause yet?
>> > 
>> 
>> I admit to generally being in the same boat as you with respect to
>> running complex userspace apps.
>> 
>> However, based on this and other scattered reports, I'd say it seems
>> quite likely that token based thrashing control is the culprit. Based
>> on the cost/benefit, I wonder if we should disable TBTC by default for
>> 2.6.10, rather than trying to fix it, and try again for 2.6.11?
>> 
>> Rik? Andrew?
>> 
>> Also, it would be nice to have a sysctl to *completely* disable TBTC,
>> that would make testing easier.
> 
> Except that disabling it (with 0) reportedly did not solve the problem.  There is 
> a possibility that its a more complex issue...

Disabling it is more than setting it to 0. Removing the patch disables it 
and this does fix the problem. We need it to be truly possible to disable 
it. See the patch I posted on this thread later.

Con

