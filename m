Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266008AbTIKBS7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 21:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265944AbTIKBRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 21:17:06 -0400
Received: from dp.samba.org ([66.70.73.150]:25986 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265914AbTIKBQt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 21:16:49 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ravi Krishnamurthy <kravi26@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Equivalent of 'insmod -m' on 2.6? 
In-reply-to: Your message of "Wed, 10 Sep 2003 11:05:07 MST."
             <20030910180507.53891.qmail@web12301.mail.yahoo.com> 
Date: Thu, 11 Sep 2003 07:03:27 +1000
Message-Id: <20030911011647.C68E32C291@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030910180507.53891.qmail@web12301.mail.yahoo.com> you write:
> Hi,
> 
> I am trying to debug a module on 2.6.0-test3 with
> module-init-tools-0.9.12. But I am not able to get
> the load map of the module being loaded. 'insmod'
> in module-init-tools does not support the '-m' option. 

Hi Ravi!

	CONFIG_KALLSYMS is probably what you want here, along with
/proc/kallsyms.  You can, also generate the equivalent of insmod -m
from the output of /proc/modules and the symbol table in the module.

BTW, I'd generally recommend modprobe over insmod: as you will have
noticed, the new insmod is designed to be a really low-level tool.

Hope this helps,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
