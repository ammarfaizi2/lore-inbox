Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbWBXXcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWBXXcZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 18:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbWBXXcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 18:32:25 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:49903 "EHLO
	pd5mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S964782AbWBXXcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 18:32:24 -0500
Date: Fri, 24 Feb 2006 17:31:20 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Drastic Slowdown of 'fseek()' Calls From 2.4 to 2.6 -- VMM Change?
In-reply-to: <5JRJO-6Al-7@gated-at.bofh.it>
To: Marr <marr@flex.com>, linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43FF9748.9010603@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <5JRJO-6Al-7@gated-at.bofh.it>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marr wrote:
> Clearly, the 2.4.31 results are speedy because the whole 4MB file has been 
> cached.

I don't think this is clear at all. The entire file should always be 
cached, not doing this would be insane.

> What I cannot figure out is this: what has changed in 2.6.x kernels to cause 
> the performance to degrade so drastically?!?

fseek() is a C library call, not a system call itself - there may be 
something that glibc is doing differently. Are you using the same glibc 
version with both kernels?

Just from this program it could be something else entirely that explains 
the difference in speed, like the random number generator..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

