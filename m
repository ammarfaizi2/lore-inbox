Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284218AbSABVSE>; Wed, 2 Jan 2002 16:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284258AbSABVR5>; Wed, 2 Jan 2002 16:17:57 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:11022 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S284302AbSABVRo>;
	Wed, 2 Jan 2002 16:17:44 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200201022117.g02LHUV425569@saturn.cs.uml.edu>
Subject: Re: system.map
To: kaos@ocs.com.au (Keith Owens)
Date: Wed, 2 Jan 2002 16:17:30 -0500 (EST)
Cc: timothy.covell@ashavan.org, adriankok2000@yahoo.com.hk (adrian kok),
        linux-kernel@vger.kernel.org
In-Reply-To: <9391.1010004875@ocs3.intra.ocs.com.au> from "Keith Owens" at Jan 03, 2002 07:54:35 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens writes:

> Current versions of ps look for System.map in
>
>       $PS_SYSTEM_MAP
>       /boot/System.map-`uname -r`
>       /boot/System.map
>       /lib/modules/`uname -r`/System.map
>       /usr/src/linux/System.map
>       /System.map
>
> Copy System.map to /lib/modules/`uname -r`/System.map after make
> modules_install, remove any old map files from /boot and / and you
> don't need any symlink or bootloader tricks.
> 
> The 2.5 kernel build asks if you want to install System.map and
> .config.  If you say yes then the default location for these files in
> 2.5 is /lib/modules/`uname -r`/{System.map,.config}.

That's not a nice place. Besides the fact that System.map is
neither library nor module, /lib/modules is less likely to
exist than /boot is. It's a wee bit slower too.

The System.map file contains info related only to the main kernel
image, and nothing related to modules. So this is better:

/boot/System.map-2.4.18-pre1
/boot/vmlinuz-2.4.18-pre1
/boot/bzImage-2.4.18-pre1
/boot/config-2.4.18-pre1

(losing the foul '.' on the .config file)
