Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263290AbTKQPqj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 10:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263561AbTKQPqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 10:46:39 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19336 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263290AbTKQPqi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 10:46:38 -0500
Message-ID: <3FB8ED43.2090102@pobox.com>
Date: Mon, 17 Nov 2003 10:46:11 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>
CC: Andrey Borzenkov <arvidjaar@mail.ru>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Is initramfs freed after kernel is booted?
References: <E1ALlQs-000769-00.arvidjaar-mail-ru@f7.mail.ru> <3FB8EBC2.1080800@nortelnetworks.com>
In-Reply-To: <3FB8EBC2.1080800@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> Andrey Borzenkov wrote:
> 
>> my example is after pivot_root. I still have two roots.
>>
>> To clarify. I want to replace initrd with initramfs. Given all
>> the stuff may be put in it can easily be expanded to a couple of MBs.
>> initrd frees this. I do not want to waste RAM to leave them in initramfs.
> 
> 
> Absolutely, the memory should be reclaimed.  I would have thought that 
> you could just unmount it--if the pivot_root is done properly there 
> shouldn't be any references left to the initramfs.
> 
> Jeff?


You can't unmount rootfs.  And I'm not sure pivot_root will work, though 
we're quickly reaching the end of my knowledge[1].  Certainly the 
equivalent of "rm -rf *" will work.

	Jeff



[1] without reviewing the code again :)

