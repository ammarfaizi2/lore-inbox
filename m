Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbTJDMYu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 08:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbTJDMXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 08:23:46 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:28120 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262011AbTJDMXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 08:23:41 -0400
Date: Thu, 2 Oct 2003 19:58:02 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Thomas Winkler <tom@qwws.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BugReport (test6): USB (ACPI), SWSUSP, E100
Message-ID: <20031002175802.GC205@openzaurus.ucw.cz>
References: <200309291551.00446.tom@qwws.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309291551.00446.tom@qwws.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> - SWSUSP 
> In contrast du test5 there now is a /proc/acpi/sleep file again. But an 
> 
> echo 4 > /proc/acpi/sleep shows no effect at all. SWSUSP is enabled in the 
> kernel (full .config at the end of the mail).

Look for [pm] patches I sent to the list; you need to add __initcall(software_resume).

> echo 3 > /proc/acpi/sleep produces the following output and then the prompt 
> returns again:
> Stopping tasks: ==================
>  stopping tasks failed (1 tasks remaining)
> Restarting tasks...<6> Strange, khubd not stopped
>  done


Turn off config_usb.

-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

