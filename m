Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286999AbSABUzp>; Wed, 2 Jan 2002 15:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287966AbSABUzk>; Wed, 2 Jan 2002 15:55:40 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:15113 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S287968AbSABUyr>;
	Wed, 2 Jan 2002 15:54:47 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: timothy.covell@ashavan.org
Cc: adrian kok <adriankok2000@yahoo.com.hk>, linux-kernel@vger.kernel.org
Subject: Re: system.map 
In-Reply-To: Your message of "Wed, 02 Jan 2002 13:26:29 MDT."
             <200201021930.g02JUCSr021556@svr3.applink.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 03 Jan 2002 07:54:35 +1100
Message-ID: <9391.1010004875@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jan 2002 13:26:29 -0600, 
Timothy Covell <timothy.covell@ashavan.org> wrote:
>	Of course, you can copy over the new System.map
>file to /boot,  but their is no (easy) way of having more than
>one active version via "lilo" or "grub".   And that could be 
>considered a deficiency of the Linux OS.

Current versions of ps look for System.map in

      $PS_SYSTEM_MAP
      /boot/System.map-`uname -r`
      /boot/System.map
      /lib/modules/`uname -r`/System.map
      /usr/src/linux/System.map
      /System.map

Copy System.map to /lib/modules/`uname -r`/System.map after make
modules_install, remove any old map files from /boot and / and you
don't need any symlink or bootloader tricks.

The 2.5 kernel build asks if you want to install System.map and
.config.  If you say yes then the default location for these files in
2.5 is /lib/modules/`uname -r`/{System.map,.config}.

