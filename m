Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266261AbUANAAu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 19:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266263AbUANAAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 19:00:50 -0500
Received: from smtp-out2.iol.cz ([194.228.2.87]:20927 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S266261AbUANAAs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 19:00:48 -0500
Date: Wed, 14 Jan 2004 00:59:39 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@redhat.com>, Pavel Machek <pavel@ucw.cz>,
       cpufreq@www.linux.org.uk, linux@brodo.de,
       kernel list <linux-kernel@vger.kernel.org>, paul.devriendt@amd.com
Subject: Re: Cleanups for powernow-k8
Message-ID: <20040113235938.GA25158@elf.ucw.cz>
References: <20040113215149.GA236@elf.ucw.cz> <20040113215918.GK14674@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040113215918.GK14674@redhat.com>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > and is way too verbose.
> 
> I agree that something like that output belongs more in x86info,
> or a standalone tool, but I think Paul wanted to keep debugging stuff
> there for the time being. Maybe silence it, and have it enabled
> with a 'debug' module param ? Paul ?

I made sure all the info is still there in dmesg, just on less lines.

>  > @@ -637,6 +629,7 @@
>  >  		}
>  >  
>  >  		if ((numps <= 1) || (batps <= 1)) {
>  > +			/* FIXME: Is this right? I can see one state on battery, two states total as an usefull config */
>  >  			printk(KERN_ERR PFX "only 1 p-state to transition\n");
>  >  			return -ENODEV;
>  >  		}
>  > the test probably should be numps <= 1 only, but it does not matter as
>  > we force numps = batps]
> 
> 1 state on battery sounds odd. Buggy BIOS ?

No if you have 1 state on battery but two on AC power. That way you
*have* to be low power on battery, but can select low or high on
AC... Ugly hardware, but Intel done this before, and it kind-of makes
sense.
								Pavel

-- 
When do you have heart between your knees?
