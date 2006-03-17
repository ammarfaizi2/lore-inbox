Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbWCQFet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWCQFet (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 00:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWCQFet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 00:34:49 -0500
Received: from rtr.ca ([64.26.128.89]:24778 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750868AbWCQFes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 00:34:48 -0500
Message-ID: <441A4A75.5030600@rtr.ca>
Date: Fri, 17 Mar 2006 00:34:45 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8) Gecko/20060305 SeaMonkey/1.1a
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc6:  swsusp cannot find swap partition
References: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <20060315103711.GA31317@suse.de> <20060315175948.GB2423@ucw.cz> <200603162133.26771.kernel@kolivas.org> <20060316104630.GA9399@atrey.karlin.mff.cuni.cz> <441A47DB.9000001@rtr.ca>
In-Reply-To: <441A47DB.9000001@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Pavel,
> 
> I have two nearly identical Kubuntu-5.10 notebooks here,
> both of which work perfectly with suspend-to-RAM and
> just about everything else.
> 
> Both of them also did swsusp until today.
> Now one of them fails, but the other still works.
> The one that failed was just upgraded from a 2.6.12-based kernel
> to the stock 2.6.16-rc6-git7, same kernel as the one that works.
> 
> I instrumented the swsusp code to try and see why it fails,
> and here (attached) is the result.  It's skipping over the swap
> partition for some reason.
> 
> Why?

Ahh.. found it.  Nevermind.

The swap partitions differ between the two machines,
but I had used (ages ago..) CONFIG_PM_STD_PARTITION="/dev/sda6"
in the kernel config on the good machine, and that's not quite
right for the other machine.

Cheers

