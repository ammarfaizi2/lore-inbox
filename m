Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264090AbUE1Wdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264090AbUE1Wdj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 18:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264119AbUE1Wao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 18:30:44 -0400
Received: from quechua.inka.de ([193.197.184.2]:21928 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S264061AbUE1W2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 18:28:52 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
Organization: Deban GNU/Linux Homesite
In-Reply-To: <200405290037.17775.vda@port.imtp.ilyichevsk.odessa.ua>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.5 (i686))
Message-Id: <E1BTpqM-0005LZ-00@calista.eckenfels.6bone.ka-ip.net>
Date: Sat, 29 May 2004 00:28:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200405290037.17775.vda@port.imtp.ilyichevsk.odessa.ua> you wrote:
>> The benchmark involved was ls.  It took several seconds.  If I ran it again
>> in 5 seconds or so, it was fine.  Much longer and it would take several
>> seconds again.  Sounds like pages getting evicted in LRU order.
> 
> By what magic system can know that you are going to do ls again
> in 2 minutes?

The problem is more about the blocks cp touches, less  about predicting the ls workload.

> cp should use fadvise() and say that it _really_ does not need those pages.

Yes, indeed. On the other hand the sequential read could be detected by the kernel, too.

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
