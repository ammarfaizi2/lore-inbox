Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbVLTVVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbVLTVVM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 16:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbVLTVVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 16:21:11 -0500
Received: from gate.crashing.org ([63.228.1.57]:27533 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932121AbVLTVVK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 16:21:10 -0500
Subject: Re: sungem hangs in atomic if netconsole enabled but no carrier
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>,
       Eric Lemoine <eric.lemoine@gmail.com>
In-Reply-To: <1135080538.3937.3.camel@localhost>
References: <1135080538.3937.3.camel@localhost>
Content-Type: text/plain
Date: Wed, 21 Dec 2005 08:18:40 +1100
Message-Id: <1135113521.10035.107.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Turns out that if I remove the netconsole=... option to my kernel, all
> works fine and the system no longer hangs. Obviously not plugging in a
> network cable is pretty useless when netconsole is turned on, but I
> think it should not hang the system completely. So far I haven't been
> able to figure out where it actually hangs and don't even know how to do
> so -- I'm open for suggestions on how to find out why/where it hangs or
> even fixes.

Hrm... I've heard various reports about problems with netconsole... I've
never tried it myself so far though. One thing I remember to beware of
is if sungem does a printk while holding its lock...

Ben.


