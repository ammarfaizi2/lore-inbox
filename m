Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264291AbUAVAYQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 19:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265817AbUAVAYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 19:24:16 -0500
Received: from ms-smtp-03.rdc-kc.rr.com ([24.94.166.129]:53648 "EHLO
	ms-smtp-03.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S264291AbUAVAYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 19:24:14 -0500
From: Paul Misner <paul@misner.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Nvidia drivers and 2.6.x kernel
Date: Wed, 21 Jan 2004 18:24:10 -0600
User-Agent: KMail/1.6
References: <200401221012.17121.chakkerz@optusnet.com.au> <200401211744.04064.paul@misner.org> <200401221105.12148.chakkerz@optusnet.com.au>
In-Reply-To: <200401221105.12148.chakkerz@optusnet.com.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401211824.10470.paul@misner.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 January 2004 06:05 pm, Christian Unger wrote:
> About module-init-tools ... dunno ... never heard of it, I'm on Slackware
> 9.1 so ... dunno ... Not sure. But like you say, if i could not initalize
> modules the nvidia module should be the least of my worries, plus
> everything loads in 2.4.22

The 2.6 kernel needs new tools to load the kernel modules, because they have a 
different format (not just a different extension with .ko).  
module-init-tools provides those necessary upgrades, and also aids in 
creating /etc/modprobe.conf, which is used instead of /etc/modules.conf under 
the 2.6 kernels for loading modules on startup.  If you don't have 
module-init-tools, then I'm not surprised you are having problems.  You 
probably need an updated mkinitrd as well if you are using an initrd on 
system startup.

They should be at http://www.kernel.org/pub/linux/kernel/people/rusty/modules/

You probably want to read a document that summarized the changes that happened 
in 2.6, which is where the link above was located.  It is 
http://www.linux.org.uk/~davej/docs/post-halloween-2.6.txt

Not knowing much about Slackware, I couldn't give you much help about where 
the best place to get your tools from might be, except for the source above.

> > What messages do you get about what is going wrong?  What happens when
> > you so a modprobe nvidia?  What does your log file from XFree show?
>
> on make install i get:
> FATAL: Error inserting nvidia (/lib/modules/2.6.1/kernel/drivers/video/
> nvidia.ko): Invalid module format
>
> That's the same thing that modprobe nvidia gets.
> I'll check the nv thing out.
>
> One interesting error / warning i get during boot is this (from /var/log/
> syslog) :
> Jan 22 10:43:08 stormcrow kernel: nvidia: version magic '2.6.1 preempt K7
> gcc-3.2' should be '2.6.1 preempt K7 gcc-3.3'
> Jan 22 10:46:15 stormcrow kernel: nvidia: version magic '2.6.1 preempt K7
> gcc-3.2' should be '2.6.1 preempt K7 gcc-3.3'
>
> Not sure what to make of this. I know that 4496 had issues with the gcc
> version i was running a while backed, and i had to hack the installer
> script to ignore that (though i'm sure there is a switch for this stuff ...
> i was over reading at that point).
>
> As for the XFree log ... i don't have that one ...

/var/log/XFree86.0.log would be the place.  I don't think there will be 
anything interesting there until you get your module-init-tools installed.

I hope this has helped.

Paul
