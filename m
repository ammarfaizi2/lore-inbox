Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030506AbWASB5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030506AbWASB5F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 20:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030508AbWASB5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 20:57:05 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:22223 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1030506AbWASB5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 20:57:02 -0500
Date: Wed, 18 Jan 2006 19:58:59 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: io performance...
In-reply-to: <5wdKh-5wF-15@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43CEF263.9060102@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=windows-1252; format=flowed
Content-transfer-encoding: 7bit
References: <5vx8f-1Al-21@gated-at.bofh.it> <5wbRY-3cF-3@gated-at.bofh.it>
 <5wdKh-5wF-15@gated-at.bofh.it>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff V. Merkey wrote:
> Max Waterman wrote:
> 
>> One further question. I get these messages 'in' dmesg :
>>
>> sda: asking for cache data failed
>> sda: assuming drive cache: write through
>>
>> How can I force it to be 'write back'?
> 
> Forcing write back is a very bad idea unless you have a battery backed 
> up RAID controller.  

This is not what these messages are referring to. Those write through 
vs. write back messages are referring to detecting the drive write cache 
mode, not setting it. Whether or not the write cache is enabled is used 
to determine whether the sd driver uses SYNCHRONIZE CACHE commands to 
flush the write cache on the device. If the drive says its write cache 
is off or doesn't support determining the cache status, the kernel will 
not issue SYNCHRONIZE CACHE commands. This may be a bad thing if the 
device is really using write caching..
	
-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

