Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbTFIXBv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 19:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbTFIXBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 19:01:50 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:26380 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id S262267AbTFIXBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 19:01:50 -0400
Date: Tue, 10 Jun 2003 01:14:56 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "David S. Miller" <davem@redhat.com>
cc: zippel@linux-m68k.org, <wa@almesberger.net>, <chas@cmf.nrl.navy.mil>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations
 (take 2)
In-Reply-To: <20030609.160013.74730356.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0306100113420.12110-100000@serv>
References: <Pine.LNX.4.44.0306082228460.5042-100000@serv>
 <20030608.223501.71104915.davem@redhat.com> <Pine.LNX.4.44.0306100011230.5042-100000@serv>
 <20030609.160013.74730356.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 9 Jun 2003, David S. Miller wrote:

>    You still need to synchronize with already running functions
> 
> netdev->dead = 1;
> netdev->op_this = NULL;
> netdev->op_that = NULL;
> netdev->op_whatever = NULL;
> synchronize_kernel();

That assumes of course that the functions don't sleep.
(RCU isn't really the answer to everything.)

bye, Roman

