Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271573AbTGQS2H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 14:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271551AbTGQS1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 14:27:48 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:58324 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S271584AbTGQSZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 14:25:59 -0400
Date: Thu, 17 Jul 2003 20:40:46 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@redhat.com>, liam.girdwood@wolfsonmicro.com
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.0-test1-ac2: ac97_plugin_wm97xx.c doesn't compile non-modular
Message-ID: <20030717184046.GG1407@fs.tum.de>
References: <200307161816.h6GIGKH09243@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307161816.h6GIGKH09243@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 02:16:20PM -0400, Alan Cox wrote:

>...
> 2.5.75-ac (never released) differences remaining unmerged
>...
> o	WM97xx touchscreen plugins			(Liam Girdwood)
>...

ac97_plugin_wm97xx.c doesn't compile non-modular:

<--  snip  -->

...
  CC      sound/oss/ac97_plugin_wm97xx.o
sound/oss/ac97_plugin_wm97xx.c: In function `wm97xx_ts_setup':
sound/oss/ac97_plugin_wm97xx.c:1274: warning: implicit declaration of 
function `strtok'
sound/oss/ac97_plugin_wm97xx.c:1274: warning: assignment makes pointer 
from integer without a cast
sound/oss/ac97_plugin_wm97xx.c:1275: warning: assignment makes pointer 
from integer without a cast
...  
LD      .tmp_vmlinux1
sound/built-in.o(.init.text+0xc4f1): In function `wm97xx_ts_setup':
: undefined reference to `strtok'
sound/built-in.o(.init.text+0xc704): In function `wm97xx_ts_setup':
: undefined reference to `strtok'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

