Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750960AbWFAVkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbWFAVkT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 17:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbWFAVkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 17:40:19 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:54371 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750960AbWFAVkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 17:40:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ZnNlDRt3BcilNoYhXBrd4KNPhD+sxTuSni3Q515Mrs0VfAMCGw929zbiVTiteTpZEujgxlvvzsQUEeOKM/TSY7RrYidiL0hP3Tw/ac7NXkbV+DfDZTvsOBBl6gkGC4fCg7fElDuVNlftHiDDrzZ5JTKjumBAZC+RDwSc0ta0Cmo=
Message-ID: <447F5EA7.7020300@gmail.com>
Date: Fri, 02 Jun 2006 05:39:51 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: "D. Hazelton" <dhazelton@enter.net>, Dave Airlie <airlied@gmail.com>,
       Jon Smirl <jonsmirl@gmail.com>, Pavel Machek <pavel@ucw.cz>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <200605282316.50916.dhazelton@enter.net> <Pine.LNX.4.61.0605312341240.30170@yvahk01.tjqt.qr> <200605312115.44907.dhazelton@enter.net> <Pine.LNX.4.61.0606011140110.3533@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0606011140110.3533@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>> As long as I can continue to use 80x25 or any of the "pure text modes"
>>> (vga=scan boot option says more) without loading any FB/DRM, I am satisfied
>> Jan, I don't plan on forcing fbdev/DRM on anyone. My work is going to leave 
>> vgacon alone, and if my work at making DRM and FBdev cooperate goes as 
>> planned, those two will remain independant, though part of my work aims at 
>> having fbdev provide all 2D graphics acceleration for DRM while DRM handles 
>> the 3D stuff via the Mesa libraries or similar.
>>
> That sounds acceptable.
> 
> But current vesafb is slower, noticable with scrolling as in `ls -Rl /`.
> Does it lack 2D acceleration?

No, vesafb does not support console acceleration.

If you use x86_32, adding video=vesafb:ypan,mtrr:3 in your boot option will
help.  Also using the lowest color depth will also help.

Tony 
