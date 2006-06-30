Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbWF3XVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbWF3XVd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 19:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbWF3XVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 19:21:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32164 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932150AbWF3XVc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 19:21:32 -0400
Date: Fri, 30 Jun 2006 16:21:00 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
cc: Alessio Sangalli <alesan@manoweb.com>, Dave Jones <davej@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cardbus: revert IO window limit
In-Reply-To: <200607010109.40486.daniel.ritz-ml@swissonline.ch>
Message-ID: <Pine.LNX.4.64.0606301614470.12404@g5.osdl.org>
References: <200607010003.31324.daniel.ritz-ml@swissonline.ch>
 <Pine.LNX.4.64.0606301516140.12404@g5.osdl.org> <200607010109.40486.daniel.ritz-ml@swissonline.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 1 Jul 2006, Daniel Ritz wrote:
> 
> errm...no. the SMBus device is in device 00:07.3 (power management controller)...
> and that has ID 8086:719b (from his lspci -vvx output)...

Ahh, right. 

Alessio, try Daniel's patch. We'd love to hear if it works, and in 
particular what the dmesg output is (if it does work, it should print out 
something like

	PIIX4 ACPI PIO at 2000-203f
	PIIX4 SMB PIO at 2040-204f

and perhaps even a few "PIIX4 devres X" lines..)

Alessio, it might also make sense to try to enable ACPI if you haven't 
done so - not because you need to use it, but because sometimes the ACPI 
table parsing also ends up exposing these kinds of things..

		Linus
