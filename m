Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265662AbUAMWBM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 17:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265661AbUAMWBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 17:01:12 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:23765 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S265662AbUAMWBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 17:01:10 -0500
Date: Tue, 13 Jan 2004 21:59:18 +0000
From: Dave Jones <davej@redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: cpufreq@www.linux.org.uk, linux@brodo.de,
       kernel list <linux-kernel@vger.kernel.org>, paul.devriendt@amd.com
Subject: Re: Cleanups for powernow-k8
Message-ID: <20040113215918.GK14674@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Pavel Machek <pavel@ucw.cz>, cpufreq@www.linux.org.uk,
	linux@brodo.de, kernel list <linux-kernel@vger.kernel.org>,
	paul.devriendt@amd.com
References: <20040113215149.GA236@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040113215149.GA236@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 13, 2004 at 10:51:49PM +0100, Pavel Machek wrote:

 > powernow-k8 uses strange kind of comments

comments part I kinda agree with, though its not critical..

 > and is way too verbose.

I agree that something like that output belongs more in x86info,
or a standalone tool, but I think Paul wanted to keep debugging stuff
there for the time being. Maybe silence it, and have it enabled
with a 'debug' module param ? Paul ?
 
 > Also powernow-k7 should just shut up when it is monolithic
 > kernel and cpu is not k7.

Agreed, applied.

 > @@ -637,6 +629,7 @@
 >  		}
 >  
 >  		if ((numps <= 1) || (batps <= 1)) {
 > +			/* FIXME: Is this right? I can see one state on battery, two states total as an usefull config */
 >  			printk(KERN_ERR PFX "only 1 p-state to transition\n");
 >  			return -ENODEV;
 >  		}
 > the test probably should be numps <= 1 only, but it does not matter as
 > we force numps = batps]

1 state on battery sounds odd. Buggy BIOS ?

		Dave

