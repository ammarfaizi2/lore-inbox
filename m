Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263558AbTDWTeg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 15:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbTDWTdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 15:33:53 -0400
Received: from smtp1.clear.net.nz ([203.97.33.27]:37251 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S263551AbTDWTdp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 15:33:45 -0400
Date: Thu, 24 Apr 2003 07:41:11 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: Fix SWSUSP & !SWAP
In-reply-to: <20030423175629.7cfc9087.gigerstyle@gmx.ch>
To: gigerstyle@gmx.ch
Cc: Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Message-id: <1051126871.1893.35.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <20030423135100.GA320@elf.ucw.cz>
 <Pine.GSO.4.21.0304231631560.1343-100000@vervain.sonytel.be>
 <20030423144705.GA2823@elf.ucw.cz> <20030423175629.7cfc9087.gigerstyle@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Swsusp will use the portion of your swap partition that is unused when
you start to suspend. The version currently in the 2.5 tree frees most
of your memory before suspending, and so doesn't need that much swap at
all. The version that I'm working on merging only frees memory if it is
necessary to fit the image in the available swap or to have enough
memory to be able to save the image. Thus, you need a lot more swap for
my version. (eg. I have 640MB ram on my laptop and a ~700MB swap
partition).

Hope this helps.

Regards,

Nigel

On Thu, 2003-04-24 at 03:56, gigerstyle@gmx.ch wrote:
> Hi All,
> 
> Just a quick question:
> 
> As I know, swsusp is for hybernation (S4), right? The memory content
> will be written to the swap partition. What happens if the swap space
> is already used from programs? Abort? Or do I have to reserve swap
> space which never has to be used from programs?
> 
> Thank you!
> 
> Marc
> 
> 
> -- 
> Nigel Cunningham
> 495 St Georges Road South, Hastings 4201, New Zealand
> 
> Be diligent to present yourself approved to God as a workman who does
> not need to be ashamed, handling accurately the word of truth.
> 	-- 2 Timothy 2:14, NASB.

