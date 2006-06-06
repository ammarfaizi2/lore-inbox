Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932079AbWFFEVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWFFEVX (ORCPT <rfc822;akpm@zip.com.au>);
	Tue, 6 Jun 2006 00:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbWFFEVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 00:21:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19617 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932079AbWFFEVW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 00:21:22 -0400
Date: Mon, 5 Jun 2006 21:20:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mingo@elte.hu, alan@lxorguk.ukuu.org.uk, arjan@infradead.org,
        alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] misroute-irq: Don't call desc->chip->end because of
 edge interrupts
Message-Id: <20060605212033.072bb47d.akpm@osdl.org>
In-Reply-To: <1149564830.16247.11.camel@localhost.localdomain>
References: <1149112582.3114.91.camel@laptopd505.fenrus.org>
	<1149345421.13993.81.camel@localhost.localdomain>
	<20060603215323.GA13077@devserv.devel.redhat.com>
	<1149374090.14408.4.camel@localhost.localdomain>
	<1149413649.3109.92.camel@laptopd505.fenrus.org>
	<1149426961.27696.7.camel@localhost.localdomain>
	<1149437412.23209.3.camel@localhost.localdomain>
	<1149438131.29652.5.camel@localhost.localdomain>
	<1149456375.23209.13.camel@localhost.localdomain>
	<1149456532.29652.29.camel@localhost.localdomain>
	<20060604214448.GA6602@elte.hu>
	<1149564830.16247.11.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Jun 2006 23:33:50 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> Hit the following BUG with irqpoll.  The below patch fixes it.
> 

Call me a cynic, but

> +		if (work && disc->chip && desc->chip->end)

that doesn't look super-tested to me.
