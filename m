Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbVK2Ttr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbVK2Ttr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 14:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbVK2Ttr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 14:49:47 -0500
Received: from [85.8.13.51] ([85.8.13.51]:44709 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S932363AbVK2Ttq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 14:49:46 -0500
Message-ID: <438CB0D8.90607@drzeus.cx>
Date: Tue, 29 Nov 2005 20:49:44 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.7-2.1.fc4.nr (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, tiwai@suse.de
CC: linux-kernel@vger.kernel.org, ambx1@neo.rr.com
Subject: Re: [Fwd: [PATCH] [PNP][RFC] Suspend support for PNP bus.]
References: <436B2819.4090909@drzeus.cx>	<20051129113210.3d95d71f.akpm@osdl.org>	<438CA2D9.8030304@drzeus.cx> <20051129120212.3e679296.akpm@osdl.org>
In-Reply-To: <20051129120212.3e679296.akpm@osdl.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Pierre Ossman <drzeus-list@drzeus.cx> wrote:
>  
>
>>Andrew Morton wrote:
>>
>>    
>>
>>>Pierre Ossman <drzeus-list@drzeus.cx> wrote:
>>> 
>>>
>>>      
>>>
>>>>Add support for suspending devices connected to the PNP bus. New
>>>>callbacks are added for the drivers and the PNP hardware layer is
>>>>told to disable the device during the suspend.
>>>>   
>>>>
>>>>        
>>>>
>>>The ALSA guys have gone off and implemented their own version of this, and
>>>it's a bit different.   I'll need to drop this patch now.
>>>
>>>Please review http://www.zip.com.au/~akpm/linux/patches/stuff/git-alsa.patch, sort
>>>things out?
>>> 
>>>
>>>      
>>>
>>That things is huge! Do the ALSA guys perhaps have a patch with just the
>>PnP bit in it?
>>
>>    
>>
>
>http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/perex/alsa-current.git;a=commitdiff;h=5353d906effe648dd20899fe61ecb6982ad93cdd
>
>  
>

That patch is a bit dumber than mine. It doesn't do anything but call
the driver supplied suspend/resume function, i.e. no PnP handling during
suspend. It does handle cards though, something my patch doesn't do.
Perhaps a combination of the two is acceptable to the ALSA crowd?

Rgds
Pierre

