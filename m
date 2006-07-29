Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751378AbWG2TAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbWG2TAx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 15:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbWG2TAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 15:00:53 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:31872 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751378AbWG2TAw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 15:00:52 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: swsusp regression (s2dsk) [Was: 2.6.18-rc2-mm1]
Date: Sat, 29 Jul 2006 20:59:58 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, pavel@suse.cz,
       linux-pm@osdl.org, linux-mm@kvack.org
References: <20060727015639.9c89db57.akpm@osdl.org> <44CBA1AD.4060602@gmail.com>
In-Reply-To: <44CBA1AD.4060602@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607292059.59106.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Saturday 29 July 2006 19:58, Jiri Slaby wrote:
> Andrew Morton napsal(a):
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc2/2.6.18-rc2-mm1/
> 
> Hello,
> 
> I have problems with swsusp again. While suspending, the very last thing kernel
> writes is 'restoring higmem' and then hangs, hardly. No sysrq response at all.
> Here is a snapshot of the screen:
> http://www.fi.muni.cz/~xslaby/sklad/swsusp_higmem.gif
> 
> It's SMP system (HT), higmem enabled (1 gig of ram).

Most probably it hangs in device_power_up(), so the problem seems to be
with one of the devices that are resumed with IRQs off.

Does vanila .18-rc2 work?

Rafael
