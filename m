Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262507AbVCWAKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262507AbVCWAKe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 19:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262522AbVCWAKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 19:10:34 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:19642 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S262507AbVCWAJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 19:09:21 -0500
Date: Tue, 22 Mar 2005 18:07:44 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Invalidating dentries
In-reply-to: <3Kxue-6D8-35@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4240B350.90606@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <3Kx1c-6iK-37@gated-at.bofh.it> <3Kxue-6D8-35@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os wrote:
> On Mon, 21 Mar 2005, Jan Engelhardt wrote:
> 
>> Hello list,
>>
>>
>> how can I invalidate all buffered/cached dentries so that ls -l 
>> /somefolder
>> will definitely go read the harddisk?
>>
> 
> fsync() on the file(s) in the directory then fsync() on the directory
> itself. For this, one can open the directory as though it was
> just a file, you don't need opendir().

I don't think this is what they want, it sounds like they want to 
effectively clear the read cache for the file system. I'm not sure 
there's an easy way to do that other than maybe umounting and mounting 
the file system again..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


