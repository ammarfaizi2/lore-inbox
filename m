Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbVIDRfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbVIDRfE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 13:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbVIDRfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 13:35:04 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:11416 "EHLO
	pd4mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932080AbVIDRfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 13:35:01 -0400
Date: Sun, 04 Sep 2005 11:33:53 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: RFC: i386: kill !4KSTACKS
In-reply-to: <4J1DC-2NU-1@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <431B3001.20300@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <4I7UM-M1-1@gated-at.bofh.it> <4ITG4-8nH-1@gated-at.bofh.it>
 <4J1DC-2NU-1@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume Chazarain wrote:
> Just a thought : why couldn't ndiswrapper set apart some piece
> of memory and use it as the stack by changing the esp register
> before executing windows code.
> 
> Like http://article.gmane.org/gmane.linux.drivers.ndiswrapper.general/4737
> 
> It's dirty, I know, but after all they are executing win32 code ...
> 
> Why wouldn't this work ?

I think this would be a good idea. I don't see any reason in principle 
why the ndiswrapper code couldn't use a separate stack for the Win32 
driver code. Sharing the stack between the Linux kernel and whatever 
junk is going on inside the Windows driver seems rather inherently fragile..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

