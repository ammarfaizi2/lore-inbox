Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265353AbUFBXGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265353AbUFBXGR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 19:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265361AbUFBXGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 19:06:17 -0400
Received: from assocf.lnk.telstra.net ([139.130.70.240]:19716 "EHLO
	barclay.rtc.vic.edu.au") by vger.kernel.org with ESMTP
	id S265353AbUFBXGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 19:06:00 -0400
Message-ID: <40BC5E8C.3020509@linuxmail.org>
Date: Tue, 01 Jun 2004 20:46:36 +1000
From: Nigel Cunningham <ncunningham@linuxmail.org>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Rob Landley <rob@landley.net>, Andrew Morton <akpm@osdl.org>,
       cef-lkml@optusnet.com.au, linux-kernel@vger.kernel.org, seife@suse.de
Subject: Re: swappiness=0 makes software suspend fail.
References: <200405280000.56742.rob@landley.net> <20040529222308.GA1535@elf.ucw.cz> <20040531031743.0d7566e3.akpm@osdl.org> <200405310638.21015.rob@landley.net> <20040531115259.GC28188@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20040531115259.GC28188@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Pavel Machek wrote:
>>>btw, software suspend wrecks your swap partition if you suspend to swap but
>>>do not resume from swap - you need to run mkswap again.  Seems odd.
>>
>>I think it's intentional, so that if you you boot to a different kernel swapon 
>>-a won't automount the swap partition and hork your saved image.
> 
> 
> Actually, we *want* to hork that saved image, because it is extremely
> dangerous to resume from it.
> 
> We also want to kill suspend signature ASAP, so that if driver kills
> resume and user presses reset, we will not try to resume again and
> fail in exactly same way.
> 								Pavel

Suspend2 fixes the header and records when you've attempted to resume from it. If you try a second 
time it gives you the option of invalidating the image or trying to resume. Pavel, feel free to grab 
the code out of suspend2 if you want.

Nigel
-- 
Nigel & Michelle Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (417) 100 574 (mobile)

Intolerance (n): Holding a view point with any degree of
  conviction.

