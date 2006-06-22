Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161338AbWFVUiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161338AbWFVUiP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 16:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161341AbWFVUiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 16:38:15 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:59664 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161338AbWFVUiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 16:38:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=DPRzw7A/gfWP/iTZyRH4Uu+CvnwNP5cBqq7HEIfkYnEUWZOBC0aKKcOc7D44Cj4MDgKnCRJ30Vin4TDH4YUyeVpx4rZJx2CYMjNgJmDU0LMAGT5Fe5zTnYrYkf30nlozd1tdLJcIhbh2z+AWTrMz+R/uK643WKFTouEYjv6okLY=
Message-ID: <449AFFAD.2030601@gmail.com>
Date: Thu, 22 Jun 2006 22:37:42 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, pavel@suse.cz, linux-pm@osdl.org
Subject: Re: [linux-pm] swsusp regression [Was: 2.6.17-mm1]
References: <Pine.LNX.4.44L0.0606221505030.5772-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0606221505030.5772-100000@iolanthe.rowland.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern napsal(a):
>> Ok, the problem is in verify_suspended(), we are not detecting what type
>> of device this is.
>>
>> Alan, what are you trying to check for here?  What "bogus requests" were
>> you seeing from sysfs that you are trying to filter out?
> 
> I didn't write that routine, Dave Brownell did.  It has been there for
> ages.  The "bogus requests" are attempts by the user to suspend a USB
> device (by writing to /sys/devices/.../power/state) without first
> suspending all its children and interfaces.
> 
> (This can't happen when doing a global suspend because the PM core 
> iterates through the entire device tree.  It matters only for "runtime" or 
> "selective" suspend.)

But everything I did is:
echo reboot > /sys/power/disk
echo disk > /sys/power/state

No writing anywhere else.

regards,
-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
