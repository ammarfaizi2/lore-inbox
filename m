Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbVI1T3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbVI1T3f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 15:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbVI1T3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 15:29:35 -0400
Received: from web34114.mail.mud.yahoo.com ([66.163.178.112]:24707 "HELO
	web34114.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750731AbVI1T3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 15:29:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=NBx67W+Bn00fHThIaTgrOdML9TDAoJPLrc4Uqwa0Gvdh798yANIXjnyypkWOPiU7JQtOGHQ7xjwKu3e2UEH7KZdvUPG1MeN258l4TuasE6Ya6tNTILmwFv7p5LujqGY9bEO2vWwlBqhicgF50YSz9uAmQ/BkB4NXFIfNtZZp4hE=  ;
Message-ID: <20050928192934.56067.qmail@web34114.mail.mud.yahoo.com>
Date: Wed, 28 Sep 2005 12:29:34 -0700 (PDT)
From: Wilson Li <yongshenglee@yahoo.com>
Subject: Slow loading big kernel module in 2.6 on PPC platform
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to port several third party kernel modules from kernel
2.4 to 2.6 on a ppc (MPC824x) platform. For small size of modules, it
works perfectly in 2.6. But there's one huge kernel module which size
is about 2.7M bytes (size reported by lsmod after insmod), and it
takes about 90 seconds to load this module before init_module starts.
I did not notice there's such obvious delay in 2.4 kernel.

Initially I suspected there might be a problem of the insmod of
busybox I was using. I switched to module-init-tools-3.1 insmod. It
didn't help. I also tried other things like disabling CONFIG_KALLSYMS
and commenting out all the EXPORT_SYMBOLs in that module. Nothing
works so far. I've not been able to find any relevant thread about
slow loading of big kernel module on PPC platform.

Is this related to the new way of loading kernel module in 2.6 or
vmalloc since the kernel module also needs contiguous memory? I am
running 2.6.8 kernel on a ppc platform (MPC824x) with 24M bytes
memory visible to kernel. Two small kernel modules are loaded first
through shell command right after system boots up. And there are
about 10M bytes free memory left before loading this big chunk. The
memory seems big enough to me and memory is not that fragmented since
it just boots up. 

Any suggestions?

Thanks a lot,
Wilson Li






		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
