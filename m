Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbUDSEoF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 00:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbUDSEoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 00:44:05 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:4113 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262730AbUDSEoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 00:44:03 -0400
Date: Mon, 19 Apr 2004 06:42:57 +0200
From: Willy Tarreau <w@w.ods.org>
To: ameer armaly <ameer@charter.net>
Cc: linux-kernel@vger.kernel.org, linus@osdl.org
Subject: Re: [patch] config option to make at keyboards beep when too many keys are pressed
Message-ID: <20040419044257.GH596@alpha.home.local>
References: <Pine.LNX.4.58.0404182147160.828@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0404182147160.828@debian>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 18, 2004 at 09:49:53PM -0400, ameer armaly wrote:

> +#else
> +printk(KERN_ALERT, "\007");
> +#endif			goto out;

Not speaking about poor indentation, this is not the right solution. You
will pollute system logs with \007, and you might even send the beep far
away from the keyboard, if the console is on a serial terminal. A better
solution would be to call a function which activates the local speaker,
typically the one used to output "\007" on a vt.

> +config BEEP_TOMANEY_KEYS
> +bool "Beep when too many keys are pressed on at keyboards"
> +depends on KEYBOARD_ATKBD

please respect indentation here too, just as it is below :

>  config KEYBOARD_SUNKBD
>  	tristate "Sun Type 4 and Type 5 keyboard support"
>  	depends on INPUT && INPUT_KEYBOARD

Regards,
Willy

