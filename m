Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266988AbTGLQSR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 12:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266205AbTGLQQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 12:16:14 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15879 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266988AbTGLQP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 12:15:59 -0400
Date: Sat, 12 Jul 2003 17:30:39 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jaakko Niemi <liiwi@lonesom.pp.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hang with pcmcia wlan card
Message-ID: <20030712173039.A17432@flint.arm.linux.org.uk>
Mail-Followup-To: Jaakko Niemi <liiwi@lonesom.pp.fi>,
	linux-kernel@vger.kernel.org
References: <87fzldxcf5.fsf@jumper.lonesom.pp.fi> <873chbyasi.fsf@jumper.lonesom.pp.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <873chbyasi.fsf@jumper.lonesom.pp.fi>; from liiwi@lonesom.pp.fi on Sat, Jul 12, 2003 at 07:22:53PM +0300
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 12, 2003 at 07:22:53PM +0300, Jaakko Niemi wrote:
> 
> > Hi,
> >
> >My laptop (thinkpad 570e) hangs hard straight after bringing up
> >interface with d-link dwl-650 wlan card. 2.5.73-bk1 works and
> >2.5.73-bk2 to 2.5.75-bk1 hang. If I boot without the card,
> >everything comes up, but inserting the card results to a hang.
> >Setting nmi_watchdog=2 has no effect.
> 
>  Ok, bit more info: same thing happens with edimax 8139 based
>  cardbus nic also. I've disabled apm and acpi from kernel 
>  and going to start going through the pci changes between 
>  2.5.73-bk1 and bk2. Any clues would be much appreciated.

Its a hotplug/netdevice interaction, and it happens for many hotpluggable
network devices, whether they be NE2K cards, wireless cards or whatever.

AFAICS, it isn't a PCMCIA nor cardbus problem.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

