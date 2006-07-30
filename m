Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbWG3KmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWG3KmK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 06:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWG3KmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 06:42:10 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:57502
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S932251AbWG3KmJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 06:42:09 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Trying to get my shiny new G5 (quad 2.5GHz) to boot under Linux
Date: Sun, 30 Jul 2006 12:41:26 +0200
User-Agent: KMail/1.9.1
References: <F6CAEB68-69AF-436F-8B45-08895CA180C5@mac.com>
In-Reply-To: <F6CAEB68-69AF-436F-8B45-08895CA180C5@mac.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>,
       LKML Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607301241.27053.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 July 2006 04:06, Kyle Moffett wrote:
> I just bought a brand new absolute-bleeding-edge Quad 2.5GHz G5 (it's  
> actually dual-proc dual-core, but that's marketing for you) and I'm  
> trying to find a kernel that will boot the system.  Well actually I'm  
> _trying_ to install Debian but I have yet to even get to mounting the  
> initramfs.  Here's a list of the kernels I've tried:
> 
>    Debian-Installer beta2 (I think this is 2.6.15?)
>    Debian 2.6.16-1-powerpc64
>    Debian 2.6.17-1-powerpc64
>    Custom 2.6.18-rc2+git (64821324ca49f24be1a66f2f432108f96a24e596)
> 
> The first two Debian kernels didn't get past "Setup Arch" in the  
> OpenFirmware text console; they just hung with black text on a white  
> screen and spun the fans up to full blast after a few seconds.  I  
> _think_ they were missing a PowerMac dual-core fix of some kind that  
> went into 2.6.17, although my googling wasn't terribly informative.   
> The third debian kernel got into driver init code and failed when the  
> i8250 serial driver claimed some resource and broke the zilog serial  
> driver.  I couldn't figure out if a fix for this ever made it into  
> the latest kernel, so I built a custom kernel for my G5 from my older  
> G4 (ARCH=powerpc).  This kernel dies in the SMU code with the  
> following panic (WARNING: Typed by hand from the console, so there  
> may be small typos).  My .config is attached.
> 
> If you have gotten Linux to boot on the Quad G5; I'd really  
> appreciate it if you could send me a working .config (or even better,  
> a working vmlinux image).  Thanks for all your help!

Here we go.
This is a 2.6.18-rc2 kernel (well, some git snapshot from about
a week ago). It works fine on my 2.5Ghz Quad.

.config:
http://bu3sch.de/misc/config-g5.gz

vmlinux.strip:
http://bu3sch.de/misc/linux-g5.gz

-- 
Greetings Michael.
