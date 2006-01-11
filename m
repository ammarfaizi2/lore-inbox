Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932626AbWAKIoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932626AbWAKIoR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 03:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932630AbWAKIoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 03:44:16 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:25259
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932626AbWAKIoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 03:44:15 -0500
Date: Wed, 11 Jan 2006 00:44:18 -0800 (PST)
Message-Id: <20060111.004418.92939254.davem@davemloft.net>
To: drepper@redhat.com
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: ntohs/ntohl and bitops
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <43C4C37B.9020801@redhat.com>
References: <20060111.000020.25886635.davem@davemloft.net>
	<1136967192.2929.6.camel@laptopd505.fenrus.org>
	<43C4C37B.9020801@redhat.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ulrich Drepper <drepper@redhat.com>
Date: Wed, 11 Jan 2006 00:36:11 -0800

> Anyway, candidates for this kind of transformation:
> 
> net/ipx/af_ipx.c:1450:  if (ntohs(addr->sipx_port) <
> IPX_MIN_EPHEMERAL_SOCKET &&

Does it work for comparisons?  F.e.:

     if (val < ntohs(VAL))



