Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751425AbWAEWXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbWAEWXw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 17:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWAEWXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 17:23:51 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:47581 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751425AbWAEWXv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 17:23:51 -0500
Date: Thu, 5 Jan 2006 23:23:38 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Dominik Brodowski <linux@dominikbrodowski.net>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys interface
Message-ID: <20060105222338.GG2095@elf.ucw.cz>
References: <20051227213439.GA1884@elf.ucw.cz> <d120d5000512271355r48d476canfea2c978c2f82810@mail.gmail.com> <20051227220533.GA1914@elf.ucw.cz> <Pine.LNX.4.50.0512271957410.6491-100000@monsoon.he.net> <20060104213405.GC1761@elf.ucw.cz> <Pine.LNX.4.50.0601051329590.17046-100000@monsoon.he.net> <20060105215528.GF2095@elf.ucw.cz> <20060105221334.GA925@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060105221334.GA925@isilmar.linta.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 05-01-06 23:13:34, Dominik Brodowski wrote:
> On Thu, Jan 05, 2006 at 10:55:29PM +0100, Pavel Machek wrote:
> > > I have a firewire controller in a desktop system, and a ATI Radeon in a
> > > T42 that support D1 and D2..
> > 
> > Ok, now we have a concrete example. So Radeon supports D1. But putting
> > radeon into D1 means you probably want to blank your screen and turn
> > the backlight off; that takes *long* time anyway. So you can simply
> > put your radeon into D3 and save a bit more power.
> 
> Using your logic, you never want to put your CPU into C2 power-saving state
> instead of C3 or C4. Which is ridiculous. There are technical reasons why
> you want to put devices into different power-saving states. E.g. wakeup
> latency, ability to receive wakeup signals, snooping and so on.

Well, yes. Two years before we supported hlt, it would be stupid to
try to support multiple hlt states. We do not support hlt for any
devices today.

> In addition, your patch breaks pcmcia / pcmciautils which already uses
> numbers (which I already had to change from "3" to "2" before...).

pcmcia actually uses this? Ouch. Do you just read the power file, or
do you write to it, too?
								Pavel

-- 
Thanks, Sharp!
