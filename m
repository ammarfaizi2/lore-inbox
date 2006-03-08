Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbWCHAXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbWCHAXF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 19:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbWCHAXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 19:23:04 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:45376 "EHLO
	pd3mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S964826AbWCHAXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 19:23:02 -0500
Date: Tue, 07 Mar 2006 18:22:55 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH] Document Linux's memory barriers
In-reply-to: <5NPq4-34a-23@gated-at.bofh.it>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <440E23DF.8020703@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <5NONi-2hp-3@gated-at.bofh.it> <5NOtZ-1FO-27@gated-at.bofh.it>
 <5NPgs-2Rw-37@gated-at.bofh.it> <5NPq4-34a-23@gated-at.bofh.it>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes wrote:
> On Tuesday, March 7, 2006 10:30 am, David Howells wrote:
>> True, I suppose. I should make it clear that these accessor functions
>> imply memory barriers, if indeed they do, and that you should use them
>> rather than accessing I/O registers directly (at least, outside the
>> arch you should).
> 
> But they don't, that's why we have mmiowb().

I don't think that is why that function exists.. It's a no-op on most 
architectures, even where you would need to be able to do write barriers 
on IO accesses (i.e. x86_64 using CONFIG_UNORDERED_IO). I believe that 
function is intended for a more limited special case.

I think any complete memory barrier description should document that 
function as well as EXPLICITLY specifying whether or not the 
readX/writeX, etc. functions imply barriers or not.

> Btw, thanks for putting together this documentation, it's desperately 
> needed.

Seconded.. The fact that there's debate over what the rules even are 
shows why this is needed so badly.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

