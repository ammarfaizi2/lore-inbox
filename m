Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261816AbUKUV4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbUKUV4f (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 16:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbUKUV4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 16:56:35 -0500
Received: from fw.osdl.org ([65.172.181.6]:33734 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261816AbUKUV43 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 16:56:29 -0500
Message-ID: <41A10E74.7030009@osdl.org>
Date: Sun, 21 Nov 2004 13:53:56 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Petri T. Koistinen" <petri.koistinen@iki.fi>
CC: roms@lpg.ticalc.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Clean up little bit gkc introduction text
References: <Pine.LNX.4.61.0411211825120.5894@dsl-prvgw1nf5.dial.inet.fi>
In-Reply-To: <Pine.LNX.4.61.0411211825120.5894@dsl-prvgw1nf5.dial.inet.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petri T. Koistinen wrote:
> Hi!
> 
> This patch cleans up little bit gkc introduction text.
> 
> What do you think about this patch? Somebody that speaks natively english should 
> probably read this thru.
> 
> Signed-off-by: Petri T. Koistinen <petri.koistinen@iki.fi>
> 
> --- linux-2.6/scripts/kconfig/gconf.c.orig	2004-11-21 16:15:16.000000000 +0200
> +++ linux-2.6/scripts/kconfig/gconf.c	2004-11-21 18:07:52.000000000 +0200
> @@ -741,22 +741,25 @@ void on_introduction1_activate(GtkMenuIt
>  {
>  	GtkWidget *dialog;
>  	const gchar *intro_text =
> -	    "Welcome to gkc, the GTK+ graphical kernel configuration tool\n"
> -	    "for Linux.\n"
> -	    "For each option, a blank box indicates the feature is disabled, a\n"
> -	    "check indicates it is enabled, and a dot indicates that it is to\n"
> -	    "be compiled as a module.  Clicking on the box will cycle through the three states.\n"
> +	    "Welcome to gkc, the graphical configuration tool for Linux "
> +	    "kernel.\n"

a.  It's actually built and used as 'gconfig', so change gkc to
gconfig.

b.  gconfig is not the only graphical config tool, so saying "the
graphical configuration tool" is misleading.  'xconfig' is also
available.

I would just change the first sentence from gkc to gconfig and
be done for that part.

>  	    "\n"
> -	    "If you do not see an option (e.g., a device driver) that you\n"
> -	    "believe should be present, try turning on Show All Options\n"
> -	    "under the Options menu.\n"
> -	    "Although there is no cross reference yet to help you figure out\n"
> -	    "what other options must be enabled to support the option you\n"
> -	    "are interested in, you can still view the help of a grayed-out\n"
> -	    "option.\n"
> +	    "For each option, an empty box indicates the feature is disabled,\n"
> +	    "a check indicates it is enabled, and a dot indicates that it "
> +	    "will be compiled as a module.  Click the box to cycle through "
> +	    "the possible states.\n"
>  	    "\n"

When I use gconfig, I see empty box, dash "-" for module, or "x"
in the box for built-in.  Is this just something wacky about my
gtk+ tools, or is the help text just wrong here?
Empty, "dot", and check-mark are what I see for xconfig (Qt tools).

> -	    "Toggling Show Debug Info under the Options menu will show \n"
> -	    "the dependencies, which you can then match by examining other options.";
> +	    "If you do not see an option (e.g. a device driver) that you "
> +	    "believe should be present, try turning on `Show all options' "
> +	    "from the `Options' menu.\n"
> +	    "\n"
> +	    "Although there is no cross reference to help figure out what "
> +	    "other options must be enabled to support the option you want, "
> +	    "you can still view the help of a disabled option.\n"

I would prefer:
              you can still view the help text of a disabled option.

> +	    "\n"
> +	    "Toggling `Show debug info' under the `Options' menu will show you "
> +	    "the dependencies, which you can then match by examining other "
> +	    "options.";

This is correct for xconfig, not gconfig.  Am I totally confused
here?

-- 
~Randy
