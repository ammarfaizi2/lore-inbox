Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751457AbWGXVaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbWGXVaM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 17:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbWGXVaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 17:30:12 -0400
Received: from main.gmane.org ([80.91.229.2]:41961 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751457AbWGXVaL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 17:30:11 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Johannes Engel <j-engel@gmx.de>
Subject: Re: [PATCH] Integrate asus_acpi LED's with new LED subsystem
Date: Mon, 24 Jul 2006 23:24:53 +0200
Message-ID: <ea3dr9$q5t$1@sea.gmane.org>
References: <20060706193157.GC14043@phoenix> <20060706154930.1a8fbad5.akpm@osdl.org> <20060707012025.GB8900@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-060-106-177.pools.arcor-ip.net
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
In-Reply-To: <20060707012025.GB8900@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Tuttle schrieb:
> Here is a patch to the asus_acpi driver that links the Asus laptop LED's
> into the new LED subsystem.  It creates LED class devices named
> asus:mail, asus:wireless, and asus:touchpad, depending on if the laptop
> supports the mled, wled, and tled LED's.
> 
> Since it's so new, I added a config option to turn it on and off.  It's
> worked for me, though I have an Asus M2N, which only has the mail and
> wireless LED's.
> 
> Signed-off-by: Thomas Tuttle <thinkinginbinary@gmail.com>
> 
> 
> I believe I've fixed everything you asked about, plus a few things
> Richard Purdie (the LED subsystem guy) suggested.
> 
Thanks, Thomas, for your patch. It works well for me (ASUS V6V).
There is only one thing I want to remark: Since the most recent BIOS
ASUS changed the behaviour of the touchpad LED, it is inverted now.
Until now I got around this in userspace (adapting the handler script).
But with the new led class it seems to me, we will have to deal with
that in the kernel module.
My suggestion is a new flag (tled_inv) which has to be set for every
model (always use most recent BIOS). What do you think about this?

Greetings, Johannes

