Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262761AbTKYRNX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 12:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262762AbTKYRNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 12:13:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:29086 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262761AbTKYRNU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 12:13:20 -0500
Date: Tue, 25 Nov 2003 09:13:53 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Joe Korty <joe.korty@ccur.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] possible erronous use of tick_usec in do_gettimeofday
Message-Id: <20031125091353.00dd144a.shemminger@osdl.org>
In-Reply-To: <20031125164237.GA15498@rudolph.ccur.com>
References: <1067300966.1118.378.camel@cog.beaverton.ibm.com>
	<20031027171738.1f962565.shemminger@osdl.org>
	<20031028115558.GA20482@iram.es>
	<20031028102120.01987aa4.shemminger@osdl.org>
	<20031029100745.GA6674@iram.es>
	<20031029113850.047282c4.shemminger@osdl.org>
	<16288.17470.778408.883304@wombat.chubb.wattle.id.au>
	<3FA1838C.3060909@mvista.com>
	<Pine.LNX.4.53.0310301645170.16005@chaos>
	<16289.39801.239846.9369@wombat.chubb.wattle.id.au>
	<20031125164237.GA15498@rudolph.ccur.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Nov 2003 11:42:38 -0500
Joe Korty <joe.korty@ccur.com> wrote:

> test10's version of do_gettimeofday is using tick_usec which is
> defined in terms of USER_HZ not HZ.
> 
> Against 2.6.0-test10-bk1.  Compiled, not tested, for comment only.

Your right. tick_usec is in user hz so the value of max_ntp_tick would be
too large.
