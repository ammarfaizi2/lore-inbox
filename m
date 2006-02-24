Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932559AbWBXCSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559AbWBXCSe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 21:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbWBXCSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 21:18:34 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:8367 "EHLO
	pd5mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932558AbWBXCSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 21:18:33 -0500
Date: Thu, 23 Feb 2006 20:17:33 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Mapping to 0x0
In-reply-to: <5J30B-8wi-7@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43FE6CBD.50607@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <5J30B-8wi-7@gated-at.bofh.it>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
> The mmap() usually succeeds and maps something at address 0x00000000. Now 
> what if the kernel would try to execute this (of course badly programmed) 
> code in the context of this very process?
> 
>     int (*callback)(int xyz) = NULL;
>     callback();
> 
> Would not be the badcode be executed with kernel privileges?

I'm not sure, but I would suspect it might, yes, at least on some 
platforms and configurations. However, this unlikely to be a serious 
problem, since any kernel code that executed a callback method which 
could be a NULL without checking for that would blow up the system in 
the vast majority of cases where nothing was mapped at address 0.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

