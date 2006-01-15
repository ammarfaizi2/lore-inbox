Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751923AbWAOMzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923AbWAOMzt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 07:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751924AbWAOMzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 07:55:49 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:6660 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751923AbWAOMzs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 07:55:48 -0500
Date: Sun, 15 Jan 2006 13:55:46 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Hemmann, Volker Armin" <volker.armin.hemmann@tu-clausthal.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Fw: two (little) problems wit 2.6.15-git7 one with build, one with acpi
Message-ID: <20060115125546.GA16505@mars.ravnborg.org>
References: <20060112231528.025c3a0b.akpm@osdl.org> <200601132018.04013.volker.armin.hemmann@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601132018.04013.volker.armin.hemmann@tu-clausthal.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2006 at 08:18:03PM +0100, Hemmann, Volker Armin wrote:
> I tried -git8 last night.
> make all modules_install install gave me again this error:
> 
> if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F System.map  
> 2.6.15-git8; fi
> WARNING: Couldn't open directory /lib/modules/2.6.15-git8: No such file or 
> directory
> FATAL: Could not open /lib/modules/2.6.15-git8/modules.dep.temp for writing: 
> No such file or directory
> make: *** [_modinst_post] Fehler 1

Do you have KBUILD_OUTPUT set in your environment?
That may explain it since things are running too much in parallel with
KBUILT_OUTPUT set - reported by Keith Owns a few days ago.

I have tried the above on my machine and was not able to reproduce it.

Can you please drop me the output with V=1 so I can see what is
happening. Maybe in private mail if it gets too big.

	Sam
