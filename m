Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262167AbVCPABr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262167AbVCPABr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 19:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262171AbVCPABp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 19:01:45 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:31022 "EHLO
	pd3mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S262167AbVCPAAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 19:00:01 -0500
Date: Tue, 15 Mar 2005 17:59:30 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Bogus buffer length check in linux-2.6.11  read()
In-reply-to: <3IoOm-5M2-49@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <423776E2.5000801@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <3IoOm-5M2-49@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os wrote:
> 
> The attached file shows that the kernel thinks it's doing
> something helpful by checking the length of the input
> buffer for a read(). It will return "Bad Address" until
> the length is 1632 bytes.  Apparently the kernel thinks
> 1632 is a good length!

Likely because only 1632 bytes of memory is accessible after the start 
of the buf buffer, and trying to read in more than that results in 
copy_to_user failing to write some data.

> 
> Did anybody consider the overhead necessary to do this
> and the fact that the kernel has no way of knowing if
> the pointer to the buffer is valid until it actually
> does the write. What was wrong with copy_to_user()?
> Why is there the additional bogus check?

What additional check?

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

