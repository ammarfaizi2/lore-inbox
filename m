Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932528AbVI3Ay7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbVI3Ay7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 20:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932534AbVI3Ay6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 20:54:58 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:31692
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932528AbVI3Ay5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 20:54:57 -0400
Subject: Re: [PATCH] RT: update rcurefs for RT
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Daniel Walker <dwalker@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <1128007259.11511.4.camel@c-67-188-6-232.hsd1.ca.comcast.net>
References: <1127845926.4004.22.camel@dhcp153.mvista.com>
	 <20050929114235.GA638@elte.hu>
	 <1128007259.11511.4.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Content-Type: text/plain
Organization: linutronix
Date: Fri, 30 Sep 2005 02:55:50 +0200
Message-Id: <1128041750.15115.367.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-29 at 08:20 -0700, Daniel Walker wrote:
> +static inline void init_rcurefs(void)
> +{
> +	int i;
> +	for (i=0; i < RCUREF_HASH_SIZE; i++) 
> +		__rcuref_hash[i] = SPIN_LOCK_UNLOCKED(__rcuref_hash[i]);

Maybe a simple 

	spin_lock_init(&__rcuref_hash[i]);

would work all over tha place ?

tglx


