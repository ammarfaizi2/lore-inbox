Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965126AbWJJJT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965126AbWJJJT2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 05:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965127AbWJJJT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 05:19:28 -0400
Received: from smtp1.versatel.nl ([62.58.50.88]:59540 "EHLO smtp1.versatel.nl")
	by vger.kernel.org with ESMTP id S965126AbWJJJT1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 05:19:27 -0400
Message-ID: <452B6569.7050404@hhs.nl>
Date: Tue, 10 Oct 2006 11:18:33 +0200
From: Hans de Goede <j.w.r.degoede@hhs.nl>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
CC: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hwmon/abituguru: handle sysfs errors
References: <20061010065359.GA21576@havoc.gtf.org>	<452B4B59.1050606@hhs.nl> <20061010110803.1a70b576.khali@linux-fr.org>
In-Reply-To: <20061010110803.1a70b576.khali@linux-fr.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jean Delvare wrote:
> Hi Hans, Jeff,
> 
>> You (Jean) already mailed me about this and it was on my todo list,
>> but I'm currently rather busy with work. So it looks like Jeff beat
>> me to it.
>>
>> Jeff's patch looks fine, please apply. Thanks Jeff!
> 
> The patch isn't wrong per se, but it could be made more simple, and is
> incomplete in comparison to what was done for all other hardware
> monitoring drivers:
> 
> * We want to create all the files before registering with the hwmon
>   class, this closes a race condition.

OK

> * We want to delete all the device files at regular cleanup time (after
>   unregistering with the hwmon class).

Is this really nescesarry? AFAIK the files get deleted when the device gets deleted.

> * It's OK to call device_create_file() on a non-existent file, so the
>   error path can be simplified.
> 

?? You mean device_remove_file I assume?

> I'd like the abituguru driver to behave the same as all other hardware
> monitoring drivers to lower the maintenance effort. Can either you
> or Jeff work up a compliant patch? 
> 

I understand Jeff any chance you can do a new revision of your patch? Otherwise I'll take care of it as time permits.

Regards,

Hans
