Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266473AbTAOQRg>; Wed, 15 Jan 2003 11:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266645AbTAOQRg>; Wed, 15 Jan 2003 11:17:36 -0500
Received: from penguin-ext.wise.edt.ericsson.se ([193.180.251.47]:23029 "EHLO
	penguin.wise.edt.ericsson.se") by vger.kernel.org with ESMTP
	id <S266473AbTAOQRf>; Wed, 15 Jan 2003 11:17:35 -0500
X-Sybari-Trust: c1834b99 1864f774 206fc897 00000138
From: Miklos.Szeredi@eth.ericsson.se (Miklos Szeredi)
Date: Wed, 15 Jan 2003 17:26:16 +0100 (MET)
Message-Id: <200301151626.h0FGQGu12524@duna48.eth.ericsson.se>
To: Padraig@Linux.ie
CC: Larry.Sendlosky@storigen.com, davej@codemonkey.org.uk,
       linux-kernel@vger.kernel.org
In-reply-to: <3E2588C6.4020906@Linux.ie> (Padraig@Linux.ie)
Subject: Re: VIA C3 and random SIGTRAP or segfault
References: <7BFCE5F1EF28D64198522688F5449D5AC63352@xchangeserver2.storigen.com> <3E257488.3000006@Linux.ie> <200301151556.h0FFupx12324@duna48.eth.ericsson.se> <3E2588C6.4020906@Linux.ie>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Well I never got SIGILL as would be expected. I got SEGFAULTs
> and I'm only speculating that a CMOV was encountered.
> But yes that does seem to be what's happening, the
> CMOV corrupts something global to many apps, and
> "every now and then" SEGFAULT.

That is exactly the behavior I'm seeing.  When xmms is run by one user
under gnome it crashes after some random amount of time.  Other users
or under kde xmms _never_ crashes.  

> You could quickly check your system with something like:
> 
> find /bin -perm +111 -type f |
> while read bin; do
>      objdump --disassemble $bin 2>/dev/null |
>      grep -q cmov && echo "$bin has cmov"
> done

Thanks I will check for cmovs.

Miklos
