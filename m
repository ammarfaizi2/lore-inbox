Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbTIQQqx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 12:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbTIQQqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 12:46:52 -0400
Received: from chaos.analogic.com ([204.178.40.224]:31880 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262182AbTIQQqv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 12:46:51 -0400
Date: Wed, 17 Sep 2003 12:49:10 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: jarausch@belgacom.net
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.14-pre7 Unresolved symbols
In-Reply-To: <20030917161954.69859BC016@numa.skynet.be>
Message-ID: <Pine.LNX.4.53.0309171244380.5852@chaos>
References: <20030917161954.69859BC016@numa.skynet.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Nov 2001 jarausch@belgacom.net wrote:

> Hi,
>
> trying to build 2.4.14-pre7 breaks with the error message
> depmod: *** Unresolved symbols in /lib/modules/2.4.14-pre7/kernel/fs/romfs/romfs.o
> depmod:         unlock_page
>
> during make modules_install.
>
> 2.4.14-pre6 is running fine here.
>
> Thank for hint,
> Helmut Jarausch
>
> Inst. of Technology
> RWTH Aachen
> Germany
>

This message shouldn't prevent the new modules from being installed.
This comes from `depmod` which is creating /lib/modules/`uname
-r`/modules.dep. When you boot the new kernel, the boot-script
will (probably) execute `depmod -a`, fixing the problem. Your
new kernel probably has unlock_page exported. The older one
probably didn't.

Tty it. It should work okay.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.


