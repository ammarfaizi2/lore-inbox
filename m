Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265444AbSJSBRN>; Fri, 18 Oct 2002 21:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265445AbSJSBRN>; Fri, 18 Oct 2002 21:17:13 -0400
Received: from pizda.ninka.net ([216.101.162.242]:41164 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265444AbSJSBRM>;
	Fri, 18 Oct 2002 21:17:12 -0400
Date: Fri, 18 Oct 2002 18:15:32 -0700 (PDT)
Message-Id: <20021018.181532.45064096.davem@redhat.com>
To: yoshfuji@linux-ipv6.org
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Sevaral MLD Fixes
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021018.125223.130322644.yoshfuji@linux-ipv6.org>
References: <20021018.125223.130322644.yoshfuji@linux-ipv6.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org>
   Date: Fri, 18 Oct 2002 12:52:23 +0900 (JST)

I am going to apply this patch, but please be more careful
in the future.  You submitted two patches which modify
the same hunk of comment to two different values, guarenteeing
that if I just run 'patch' this one will not apply without rejects.

   @@ -18,6 +18,9 @@
    /* Changes:
     *
     *	yoshfuji	: fix format of router-alert option
   + *	YOSHIFUJI Hideaki @USAGI:
   + *		- Ignore Queries for invalid addresses.
   + *		- MLD for link-local addresses.
     */
    
    #define __NO_VERSION__

Next time, please make patch relative to previous one and
tell me "this patch depends upon MLD source address selection
patch being applied first".

This way we can avoid this problem.
