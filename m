Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbVLAQZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbVLAQZx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 11:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbVLAQZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 11:25:53 -0500
Received: from rtr.ca ([64.26.128.89]:26786 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932318AbVLAQZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 11:25:52 -0500
Message-ID: <438F240F.2020300@rtr.ca>
Date: Thu, 01 Dec 2005 11:25:51 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix bytecount result from printk()
References: <438F1D05.5020004@rtr.ca> <Pine.LNX.4.64.0512010808240.3099@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0512010808240.3099@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 1 Dec 2005, Mark Lord wrote:
> 
>>On a related note, WHY does the LOG LEVEL format <6> not get
>>interpreted correctly for the first printk() after an oops report?
>
> It never gets interpreted except at the behinning of a line. Sounds like 
> the oops report perhaps prints a " " without a newline or something at the 
> end, so that the next message after that isn't a new line?

The oops report always ends with a simple newline:  printk("\n");

