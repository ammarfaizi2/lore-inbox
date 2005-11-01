Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965004AbVKAD5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004AbVKAD5K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 22:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbVKAD5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 22:57:10 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:44911 "EHLO
	pd5mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932558AbVKAD5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 22:57:09 -0500
Date: Mon, 31 Oct 2005 21:56:21 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Trouble unloading a module..
In-reply-to: <53LbV-6pW-21@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4366E765.9070603@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <53LbV-6pW-21@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Hansen wrote:
> However, on a 64bit machine (unofficial amd/emt64 debian with 2.6.8), 
> even though it seems to unload corrrectly, I get a kernel oops if an 
> application that uses the driver attempts to connect to the device after 
> it's been unloaded.

I'm guessing the driver isn't properly unregistering itself from 
wherever it is it has registered with (block/character device). Anything 
where the driver is registering function pointers, references, etc. to 
itself needs to be cleaned up on module removal.

The oops stacktrace may point to what it is that has been left behind..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

