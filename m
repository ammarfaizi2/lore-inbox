Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267453AbTACH4H>; Fri, 3 Jan 2003 02:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267456AbTACH4H>; Fri, 3 Jan 2003 02:56:07 -0500
Received: from rth.ninka.net ([216.101.162.244]:60062 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S267453AbTACH4G>;
	Fri, 3 Jan 2003 02:56:06 -0500
Subject: Re: [RFC] Migrating net/sched to new module interface
From: "David S. Miller" <davem@redhat.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org,
       "Alexey N. Kuznetsov" <kuznet@ms2.inr.ac.ru>
In-Reply-To: <20030103051033.1A2AA2C003@lists.samba.org>
References: <20030103051033.1A2AA2C003@lists.samba.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Jan 2003 00:37:04 -0800
Message-Id: <1041583024.8648.11.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-02 at 21:10, Rusty Russell wrote:
> Hmm, I thought the sched stuff all runs under the network brlock?  If
> so, it doesn't need to be held in, since it's not preemptible.

The packet schedulers transmit, not receive.
They have their own queue locking, along with the device
xmit lock.

