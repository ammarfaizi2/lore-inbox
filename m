Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275361AbTHMT0x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 15:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275362AbTHMT0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 15:26:52 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:56551 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S275361AbTHMT0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 15:26:50 -0400
Date: Wed, 13 Aug 2003 21:26:43 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: John Cherry <cherry@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test3 (compile statistics)
Message-ID: <20030813192642.GJ569@fs.tum.de>
References: <Pine.LNX.4.44.0308082228470.1852-100000@home.osdl.org> <1060643227.30492.13.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060643227.30492.13.camel@cherrypit.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 04:07:08PM -0700, John Cherry wrote:
> Compile statistics: 2.6.0-test3
> Compiler: gcc 3.2.2
> Script: http://developer.osdl.org/~cherry/compile/compregress.sh
> 
>                bzImage       bzImage        modules
>              (defconfig)  (allmodconfig) (allmodconfig)
> 
> 2.6.0-test3  0 warnings     7 warnings    984 warnings
>...                          ^^^^^^^^^^

This number is misleading.

As a result of the "uniq" in your script the warning

  include/linux/mca-legacy.h:10:2: warning: #warning "MCA legacy - 
  please move your driver to the new sysfs api"

that occurs in 8 different files is counted only once although this 
problem is in eight different files.

> John

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

