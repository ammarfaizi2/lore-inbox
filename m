Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261891AbVGaStu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbVGaStu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 14:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbVGaStu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 14:49:50 -0400
Received: from hermes.domdv.de ([193.102.202.1]:2566 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261891AbVGaStp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 14:49:45 -0400
Message-ID: <42ED1D46.4010808@domdv.de>
Date: Sun, 31 Jul 2005 20:49:42 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050724)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux@dominikbrodowski.net
Subject: Re: 2.6.13-rc4-mm1
References: <20050731020552.72623ad4.akpm@osdl.org>	<42ECD3B2.1080409@domdv.de> <20050731104702.7d16c8a1.akpm@osdl.org>
In-Reply-To: <20050731104702.7d16c8a1.akpm@osdl.org>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Andreas Steinmetz <ast@domdv.de> wrote:
> 
>>Andrew Morton wrote:
>> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc4/2.6.13-rc4-mm1/
>>
>> Andrew,
>> the good news is I can access pcmcia devices with rc4-mm1 which I
>> couldn't with at least rc3-mm1 on my x86_64 laptop. There is at least
>> one more problem with yenta_socket. Please see the attached dmesg output
>> and look for:
>>
>> Badness in __release_resource at kernel/resource.c:184
>>
>> This happens when accessing pcmcia from an initrd to read keys from a
>> pcmcia flash disk and removing the pcmcia modules afterwards.
> 
> 
> hm, OK.  That's brought to us by the below -mm-only debugging patch.  Maybe
> we should add more stuff to it to idenfify the child resources?
> 

Well, could be. Unfortunately I have zero knowledge in this area of the
kernel. Maybe Dominik can help?

-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
