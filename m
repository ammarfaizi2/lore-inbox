Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751531AbWIGLGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbWIGLGJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 07:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbWIGLGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 07:06:09 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:27881 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1751531AbWIGLGI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 07:06:08 -0400
Subject: Re: [patch 29/37] dvb-core: Proper handling ULE SNDU length of 0
From: Marcel Holtmann <marcel@holtmann.org>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Ang Way Chuang <wcang@nrg.cs.usm.my>
In-Reply-To: <20060906225740.GD15922@kroah.com>
References: <20060906224631.999046890@quad.kroah.org>
	 <20060906225740.GD15922@kroah.com>
Content-Type: text/plain
Date: Thu, 07 Sep 2006 14:57:56 +0200
Message-Id: <1157633876.30159.82.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> ULE (Unidirectional Lightweight Encapsulation RFC 4326) decapsulation
> code has a bug that allows an attacker to send a malformed ULE packet
> with SNDU length of 0 and bring down the receiving machine. This patch
> fix the bug and has been tested on version 2.6.17.11. This bug is 100%
> reproducible and the modified source code (GPL) used to produce this bug
> will be posted on http://nrg.cs.usm.my/downloads.htm shortly.  The
> kernel will produce a dump during CRC32 checking on faulty ULE packet.

the upstream code changed for 2.6.18. It has a different way of
addressing this issue, but it also changes a lot of other stuff in the
whole code. However it might be worth looking at it, because the
upstream code might be still vulnerable.

Regards

Marcel


