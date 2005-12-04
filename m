Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbVLDQoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbVLDQoZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 11:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbVLDQoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 11:44:24 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:27974 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932277AbVLDQoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 11:44:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=W/V95M0oHsCe9exY5uUKqy9yIuZIjJ+nFWMv0TsmypV/JOQoMVd14DGxtgM68yOsbHiJC6KjnlpCCcDYv//8LGVJKqgqApw565tb7S2w1dCpkD+QOYi4DXg6YU3ViWtqHZ5DRTAcI1fEGp/qqO+Ph/ipZEEaXLaaws7CHA9Tu4M=
Message-ID: <43931CDF.3080202@gmail.com>
Date: Mon, 05 Dec 2005 01:44:15 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Ethan Chen <thanatoz@ucla.edu>, linux-kernel@vger.kernel.org,
       Carlos Pardo <Carlos.Pardo@siliconimage.com>,
       Linux-ide <linux-ide@vger.kernel.org>
Subject: Re: SIL_QUIRK_MOD15WRITE workaround problem on 2.6.14
References: <438BD351.60902@ucla.edu> <438D2792.9050105@gmail.com> <438D2DCC.4010805@pobox.com> <438D3AA8.9030504@gmail.com> <438FAADC.6060907@pobox.com>
In-Reply-To: <438FAADC.6060907@pobox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> Ethan confirmed that it's 1095:3114.  Arghhh....  Maybe we should keep 
>> m15w quirk for 3114's for the time being?  Better be slow than hang. 
>> Whatever bug the m15w quirk was hiding.
> 
> 
> A generic 'slow_down_io' module option is reasonable.
> 
> It is not appropriate to apply mod15write quirk to hardware that isn't 
> affected by the chip bug.
> 
> A better solution is to write a 311x-specific interrupt handler.
> 

Hello, Jeff.  Hello, Carlos.

I bought a sii3114 controller yesterday and took out my ST3120026AS for 
testing.  The drive times out during a WRITE_EXT, and locks up.

* The ST3120026AS works perfectly on a VIA controller.
* The sii3114 controller works perfectly with Maxtor 6B080M0 drives.

I don't know.  It acts and smells like m15w problem.  What are the odds 
of having the same symptom on the same combination?

Also, I've asked one of my friends who has a sii3512 onboard controller 
and an affected seagate drive to test.  The harddisk works on 2.6.13 
with the quirk, but it freezes on 2.6.14.  m15w affected seagate drives 
does _NOT_ work on 3512 and 3114 on 2.6.14, be it m15w or something else.

-- 
tejun
