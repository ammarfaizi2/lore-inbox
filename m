Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbVCQXtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbVCQXtP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 18:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbVCQXtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 18:49:15 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:32946 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261376AbVCQXtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 18:49:10 -0500
Date: Thu, 17 Mar 2005 17:48:31 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: linux: detect application crash
In-reply-to: <3J9Nd-3qf-19@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <423A174F.6090906@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <3J9Nd-3qf-19@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allison wrote:
> Hi,
> 
> Several times when I worked with Windows, I have had a scenario when I
> am editing a file and saved some time ago and then the application
> crashes and I lose all recent data.
> 
> Can the operating system detect all application crashes ? If so, why
> can't the OS save the user data to disk before the application quits ?
> 
> How does this work in Linux. I was curious if such a functionality
> already exists in Linux. If not, what are the issues involved in
> implementing this functionality.

The OS doesn't have enough information to be able to save the app's data 
in the event of a crash in a form that would be usable or meaningful, 
since only the app knows what format its data structures are in.

The app itself could do this (installing a signal handler for segfaults, 
etc.) but the problem is that whatever caused the program to crash may 
have also left its data in a messed-up state.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

