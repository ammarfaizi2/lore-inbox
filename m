Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264277AbTFIN2D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 09:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264279AbTFIN2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 09:28:03 -0400
Received: from pizda.ninka.net ([216.101.162.242]:5524 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264277AbTFIN2A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 09:28:00 -0400
Date: Mon, 09 Jun 2003 06:38:25 -0700 (PDT)
Message-Id: <20030609.063825.123987226.davem@redhat.com>
To: baldrick@wanadoo.fr
Cc: chas@cmf.nrl.navy.mil, wa@almesberger.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations
 (take 2)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200306091537.13345.baldrick@wanadoo.fr>
References: <200306070350.h573oIsG004491@ginger.cmf.nrl.navy.mil>
	<200306091537.13345.baldrick@wanadoo.fr>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Duncan Sands <baldrick@wanadoo.fr>
   Date: Mon, 9 Jun 2003 15:37:13 +0200

   - refuse to open any more vccs; fail all attempts to send packets

My personal feeling is that there should be a way to zombie
VCCs, precisely for such events.

ATM should unlink them immediately, and mark them dead.
Anything that tries to do something with a VCC should
check that it is still alive.

With something like this you can ensure that a driver does
not get called into anymore.

It is just my non-ATM-expert opinion :-)
