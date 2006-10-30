Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbWJ3Ilm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbWJ3Ilm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 03:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWJ3Ilm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 03:41:42 -0500
Received: from crystal.sipsolutions.net ([195.210.38.204]:5298 "EHLO
	sipsolutions.net") by vger.kernel.org with ESMTP id S1751381AbWJ3Ill
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 03:41:41 -0500
Subject: Re: [PATCH] wireless-2.6 zd1211rw check against regulatory domain
	rather than hardcoded value of 11
From: Johannes Berg <johannes@sipsolutions.net>
To: Uli Kunitz <kune@deine-taler.de>
Cc: Daniel Drake <dsd@gentoo.org>, Holden Karau <holden@pigscanfly.ca>,
       zd1211-devs@lists.sourceforge.net, linville@tuxdriver.com,
       netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
       holdenk@xandros.com
In-Reply-To: <4544CBC8.5090305@deine-taler.de>
References: <f46018bb0610231121s4fb48f88l28a6e7d4f31d40bb@mail.gmail.com>
	 <453D48E5.8040100@gentoo.org>
	 <f46018bb0610240709y203d8cdbw95cdf66db23aa1ce@mail.gmail.com>
	 <453E2C9A.7010604@gentoo.org>  <4544CBC8.5090305@deine-taler.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 30 Oct 2006 09:42:29 +0100
Message-Id: <1162197749.2854.5.camel@ux156>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-sips-origin: local
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm not so sure about this. This patching might be US-specific and we 
> cannot simply apply the setting for top channel of another domain 
> instead of channel 11. One option would be to set the value only under 
> the US regulatory domain.

??
What the patch does is replace the top channel which is hardcoded to 11
by the top channel given by the current regulatory domain. How can that
be wrong? Except that you may want to init the regulatory domain from
the EEPROM but I'm not sure how the ieee80211 code works wrt. that.

johannes
