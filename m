Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbWFYR0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWFYR0n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 13:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWFYR0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 13:26:43 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:29796 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751334AbWFYR0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 13:26:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RAE8SM1lFLM9OCVwzgROkvzSZcXBG9EHDRNZCImKZI7vTgX9nvF6Szfg+dWZrEVBqQsn2cir7MSQAq5KoczejW8yNS5GmEBtwLZ2My+Nvv9BL35kM1STuL5D8PkPE6IAzBkt3dQOjAh6sR9CjomOtsvAaKIkqAnvTVjkjD6+N98=
Message-ID: <6bffcb0e0606251026gbd121dam83c1b763b8cba02d@mail.gmail.com>
Date: Sun, 25 Jun 2006 19:26:42 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Nick Piggin" <npiggin@suse.de>
Subject: Re: [patch] 2.6.17: lockless pagecache
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Linux Memory Management List" <linux-mm@kvack.org>
In-Reply-To: <20060625163930.GB3006@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060625163930.GB3006@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On 25/06/06, Nick Piggin <npiggin@suse.de> wrote:
> Updated lockless pagecache patchset available here:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/npiggin/patches/lockless/2.6.17/lockless.patch.gz
>

"make O=/dir oldconfig" doesn't work.

[michal@ltg01-fedora linux-work]$ LANG="C" make O=../linux-work-obj/ oldconfig
  GEN     /usr/src/linux-work-obj/Makefile
  HOSTCC  scripts/kconfig/zconf.tab.o
In file included from scripts/kconfig/zconf.tab.c:158:
scripts/kconfig/zconf.hash.c: In function 'kconf_id_lookup':
scripts/kconfig/zconf.hash.c:190: error: 'T_OPT_DEFCONFIG_LIST'
undeclared (first use in this function)
scripts/kconfig/zconf.hash.c:190: error: (Each undeclared identifier
is reported only once
scripts/kconfig/zconf.hash.c:190: error: for each function it appears in.)
scripts/kconfig/zconf.hash.c:190: error: 'TF_OPTION' undeclared (first
use in this function)
scripts/kconfig/zconf.hash.c:203: error: 'T_OPT_MODULES' undeclared
(first use in this function)
scripts/kconfig/zconf.tab.c: In function 'zconfparse':
scripts/kconfig/zconf.tab.c:1557: error: 'TF_OPTION' undeclared (first
use in this function)
scripts/kconfig/zconf.tab.c:1557: error: invalid operands to binary &
scripts/kconfig/zconf.tab.c:1558: warning: implicit declaration of
function 'menu_add_option'
make[2]: *** [scripts/kconfig/zconf.tab.o] Error 1
make[1]: *** [oldconfig] Error 2
make: *** [oldconfig] Error 2

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
