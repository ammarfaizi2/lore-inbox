Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751638AbWD0UhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbWD0UhJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 16:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751644AbWD0UhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 16:37:08 -0400
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:20779 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751638AbWD0UhG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 16:37:06 -0400
Message-ID: <44512B69.2030504@tmr.com>
Date: Thu, 27 Apr 2006 16:36:57 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.2) Gecko/20060409 SeaMonkey/1.0.1
MIME-Version: 1.0
To: =?UTF-8?B?R3J6ZWdvcnogSmHFm2tpZXdpY3o=?= <gryzman@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: can't compile kernels lately (2.6.16.5 and up)
References: <2f4958ff0604260639n4874c2aua1e99ec4c32d2182@mail.gmail.com>
In-Reply-To: <2f4958ff0604260639n4874c2aua1e99ec4c32d2182@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grzegorz Jaśkiewicz wrote:
> root@puppet:/usr/src/linux-2.6.16.11# make
>   CHK     include/linux/version.h
>   HOSTCC  scripts/mod/file2alias.o
> scripts/mod/file2alias.c:386: warning: 'struct input_device_id'
> declared inside parameter list
> scripts/mod/file2alias.c:386: warning: its scope is only this
> definition or declaration, which is probably not what you want

Did you try
- save .config
- make distclean (or mrproper)
- restore .config
- make oldconfig

I think there's a corner case which patch application leaves file mod 
dates wrong somehow.just "make clean" is a cure, but this is the big gun.

I realize you probably know this and tried it before asking, but it sure 
looks like what I see which I brain fart and don't clean properly before 
the next build,.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

