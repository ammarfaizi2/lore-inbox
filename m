Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261766AbVE0EuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbVE0EuS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 00:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbVE0EuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 00:50:18 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:16212 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261766AbVE0EuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 00:50:06 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: mkrufky@m1k.net
Subject: Re: 2.6.12-rc5-mm1 breaks serio: i8042 AUX port
Date: Thu, 26 May 2005 23:50:02 -0500
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-kernel@vger.kernel.org
References: <429684E7.2060609@m1k.net> <200505262217.00886.dtor_core@ameritech.net> <42969CB1.3010005@m1k.net>
In-Reply-To: <42969CB1.3010005@m1k.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505262350.03307.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 May 2005 23:06, Michael Krufky wrote:
> Dmitry Torokhov wrote:
> 
> >On Thursday 26 May 2005 21:47, Andrew Morton wrote:
> >  
> >
> >>Michael Krufky <mkrufky@m1k.net> wrote:
> >>    
> >>
> >>>In 2.6.12-rc5-mm1, I can't use my psaux mouse, but it worked perfectly 
> >>>fine in both 2.6.12-rc5 and in 2.6.12-rc4-mm2.
> >>>      
> >>>
> >>Not much point in telling me - I don't work on input code ;)
> >>
> >>Cc's added...
> >>
> >>    
> >>
> >>>In 2.6.12-rc5-mm1 , dmesg says:
> >>>
> >>>PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
> >>>Failed to disable AUX port, but continuing anyway... Is this a SiS?
> >>>If AUX port is really absent please use the 'i8042.noaux' option.
> >>>serio: i8042 KBD port at 0x60,0x64 irq 1
> >>>      
> >>>
> >>Did you try the 'i8042.noaux' option?
> >>
> >>    
> >>
> >>>This is what dmesg says in both 2.6.12-rc4-mm2 and 2.6.12-rc5 :
> >>>
> >>>PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
> >>>serio: i8042 AUX port at 0x60,0x64 irq 12
> >>>serio: i8042 KBD port at 0x60,0x64 irq 1
> >>>
> >>>I am using a Shuttle FT61 motherboard.  Is there any more information 
> >>>necessary to debug this?
> >>>      
> >>>
> >>I'd agree that this is a regression and that we should identify the code
> >>change which caused this and fix it up.
> >>
> >>Guys?
> >>
> >>    
> >>
> >
> >I plead innocence - bk-input.patch has not changed for at least a month...
> >
> >Michael, could you please try applying:
> >
> >http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc5/2.6.12-rc5-mm1/broken-out/bk-input.patch
> >
> >directly to 2.6.12-rc5 and see if it still breaks?
> >
> >  
> >
> I applied bk-input.patch directly to 2.6.12-rc5, and it did NOT break it 
> this time.  Looks like either a different patch is the culprit, or the 
> combination of this patch and another.
> 

Please try adding bk-acpi to the mix.

-- 
Dmitry
