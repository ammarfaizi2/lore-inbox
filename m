Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbUL2Wv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbUL2Wv7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 17:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbUL2Wv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 17:51:26 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:18132 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S261440AbUL2Wus (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 17:50:48 -0500
Date: Wed, 29 Dec 2004 14:56:15 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: [patch] fix sparc64 cpu_idle()
Message-ID: <20041229225615.GC70906@gaz.sfgoth.com>
References: <41D033FE.7AD17627@tv-sign.ru> <20041227160848.GC771@holomorphy.com> <2cd57c9004122911073dea0d2c@mail.gmail.com> <2cd57c9004122911523fe7a71b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cd57c9004122911523fe7a71b@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Wed, 29 Dec 2004 14:56:15 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(cc: list trimmed)

Coywolf Qi Hunt wrote:
> -	int ret = -EPERM;
> -
> -	if (current->pid != 0)
> -		goto out;
> -

Maybe just a WARN_ON(current->pid != 0) would be a good compromise... I
imagine that someone added the check for some reason but you're right that
just returning an error code (that presumably noone checks, right?) doesn't
make much sense

-Mitch
