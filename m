Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750845AbWAEWNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbWAEWNh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 17:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751819AbWAEWNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 17:13:37 -0500
Received: from isilmar.linta.de ([213.239.214.66]:26796 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1750878AbWAEWNg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 17:13:36 -0500
Date: Thu, 5 Jan 2006 23:13:34 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: Patrick Mochel <mochel@digitalimplant.org>, Andrew Morton <akpm@osdl.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys interface
Message-ID: <20060105221334.GA925@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Pavel Machek <pavel@ucw.cz>,
	Patrick Mochel <mochel@digitalimplant.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux-pm mailing list <linux-pm@lists.osdl.org>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20051227213439.GA1884@elf.ucw.cz> <d120d5000512271355r48d476canfea2c978c2f82810@mail.gmail.com> <20051227220533.GA1914@elf.ucw.cz> <Pine.LNX.4.50.0512271957410.6491-100000@monsoon.he.net> <20060104213405.GC1761@elf.ucw.cz> <Pine.LNX.4.50.0601051329590.17046-100000@monsoon.he.net> <20060105215528.GF2095@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060105215528.GF2095@elf.ucw.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 10:55:29PM +0100, Pavel Machek wrote:
> > I have a firewire controller in a desktop system, and a ATI Radeon in a
> > T42 that support D1 and D2..
> 
> Ok, now we have a concrete example. So Radeon supports D1. But putting
> radeon into D1 means you probably want to blank your screen and turn
> the backlight off; that takes *long* time anyway. So you can simply
> put your radeon into D3 and save a bit more power.

Using your logic, you never want to put your CPU into C2 power-saving state
instead of C3 or C4. Which is ridiculous. There are technical reasons why
you want to put devices into different power-saving states. E.g. wakeup
latency, ability to receive wakeup signals, snooping and so on.

In addition, your patch breaks pcmcia / pcmciautils which already uses
numbers (which I already had to change from "3" to "2" before...).

	Dominik
