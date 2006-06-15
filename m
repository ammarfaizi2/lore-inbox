Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbWFOHjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbWFOHjD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 03:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWFOHjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 03:39:03 -0400
Received: from cool.dworf.com ([193.189.190.81]:44856 "EHLO cool.dworf.com")
	by vger.kernel.org with ESMTP id S1751313AbWFOHjB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 03:39:01 -0400
Message-ID: <44910E87.3050200@dworf.com>
Date: Thu, 15 Jun 2006 09:38:47 +0200
From: David Osojnik <david@dworf.com>
Reply-To: david@dworf.com
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: bad command responsiveness Proliant DL 585
References: <448FC1CE.9090108@dworf.com>	 <1150278161.7994.13.camel@Homer.TheSimpsons.net> <449060EE.60608@dworf.com> <1150353862.8097.61.camel@Homer.TheSimpsons.net>
In-Reply-To: <1150353862.8097.61.camel@Homer.TheSimpsons.net>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

IT Works perfect when setting noatime,nodiratime on the partition!!

can i try anything else? what does this actually mean?

thanks!!

David

Mike Galbraith wrote:

>On Wed, 2006-06-14 at 21:18 +0200, David Osojnik wrote:
>  
>
>>here is the output of SysRq-T and SysRq-M:
>>
>>http://www.dworf.com/sysrq.txt
>>
>>any ideas?
>>    
>>
>
>Not really.
>
>I see I/O jammed up on reiserfs:.text.lock.journal, but you said
>reiserfs and ext3 both stall the same way.  If the journal is in the
>raid, I'd try moving it, but I can't really imagine seek troubles
>leading to 15 minutes of grinding.  I noticed that those last two
>instances of bash got nailed because of atime.  Do things get any better
>if mounted noatime, nodiratime?
>
>	-Mike
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>
