Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965844AbWKNSHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965844AbWKNSHE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 13:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966240AbWKNSHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 13:07:04 -0500
Received: from rtr.ca ([64.26.128.89]:55047 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S965844AbWKNSHC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 13:07:02 -0500
Message-ID: <455A05C2.6080508@rtr.ca>
Date: Tue, 14 Nov 2006 13:06:58 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Pavel Machek <pavel@ucw.cz>,
       Jeff Garzik <jeff@garzik.org>, Andi Kleen <ak@suse.de>,
       John Fremlin <not@just.any.name>,
       kernel list <linux-kernel@vger.kernel.org>, htejun@gmail.com,
       jim.kardach@intel.com
Subject: Re: HD head unloads
References: <87k639u55l.fsf-genuine-vii@john.fremlin.org> <20061113142219.GA2703@elf.ucw.cz> <45589008.1080001@garzik.org> <200611131637.56737.ak@suse.de> <455893E5.4010001@garzik.org> <4558B232.8080600@rtr.ca> <20061113220127.GA1704@elf.ucw.cz> <20061114034355.GB5810@khazad-dum.debian.net> <Pine.LNX.4.61.0611141021040.29913@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0611141021040.29913@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>
> Let me jump in here. Short info: Toshiba MK2003GAH 1.8" 20GB 
> PATA harddisk, in a Sony Vaio U3 (x86, gray-blue PhoenixBIOS).
> If idle for more than 5 secs, unloads. Even when not inside any OS, 
> which really sets me off.
>     So I wrote a quick workaround hack for Linux, http://tinyurl.com/y3qs6g
> It reads a predefined amount of bytes (just as much to not cause 
> slowdown yet still cause it to not unload) from the disk at fixed 
> intervals.

Thanks for the info.
Jan, in your specific case, can you not "fix it" properly with:

    hdparm -B255 /dev/?d?

(fill in your drive device there).

???
