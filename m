Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261781AbVFVSNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbVFVSNv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 14:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVFVSMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 14:12:46 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:52896 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S261587AbVFVSJq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 14:09:46 -0400
Date: Wed, 22 Jun 2005 20:12:07 +0200
From: DervishD <lkml@dervishd.net>
To: coywolf@lovecn.org
Cc: lkml <linux-kernel@vger.kernel.org>, sam@ravnborg.org
Subject: Re: [question] pass CONFIG_FOO to CC problem
Message-ID: <20050622181207.GC57@DervishD>
Mail-Followup-To: coywolf@lovecn.org, lkml <linux-kernel@vger.kernel.org>,
	sam@ravnborg.org
References: <2cd57c90050622013937d2c209@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2cd57c90050622013937d2c209@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Coywolf :)

 * Coywolf Qi Hunt <coywolf@gmail.com> dixit:
> I was expecting kbuild passes CONFIG_FOO from .config to CC
> -DCONFIG_FOO, but it doesn't.  So I have to add
> 
> ifdef CONFIG_FOO
> EXTRA_CFLAGS += -DCONFIG_FOO
> endif

    NO! You don't do it that way in the kernel. Think: if you have to
pass a '-D' option for each config item you set, you will end up with
TONS of '-D' options, in fact you probably exceed the command line
size limit.

    You have to include <linux/config.h> if I recall correctly ;)

    Good luck!

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to...
