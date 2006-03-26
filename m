Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWCZXDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWCZXDU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 18:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWCZXDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 18:03:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33682 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932167AbWCZXDT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 18:03:19 -0500
Date: Sun, 26 Mar 2006 14:58:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: lm-sensors@lm-sensors.org, r.marek@sh.cvut.cz, khali@linux-fr.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.16-mm1 3/3] rtc: add support for m41t81 & m41t85
 chips to m41t00 driver
Message-Id: <20060326145840.5e578fa4.akpm@osdl.org>
In-Reply-To: <20060324012406.GE9560@mag.az.mvista.com>
References: <440B4B6E.8080307@sh.cvut.cz>
	<zt2d4LqL.1141645514.2993990.khali@localhost>
	<20060307170107.GA5250@mag.az.mvista.com>
	<20060318001254.GA14079@mag.az.mvista.com>
	<20060323210856.f1bfd02b.khali@linux-fr.org>
	<20060323203843.GA18912@mag.az.mvista.com>
	<20060324012406.GE9560@mag.az.mvista.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mark A. Greer" <mgreer@mvista.com> wrote:
>
>  +	struct i2c_msg msgs[] = {
>  +		{ save_client->addr, 0, 1, msgbuf },
>  +		{ save_client->addr, I2C_M_RD, 8, buf }

The

	.name = value,

form would be preferred.  It reduces the possibility of silent breakage if
someone changes struct i2c_msg.
