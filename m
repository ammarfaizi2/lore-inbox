Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263094AbTJTX5F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 19:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263102AbTJTX5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 19:57:05 -0400
Received: from [65.172.181.6] ([65.172.181.6]:63700 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263094AbTJTX5D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 19:57:03 -0400
Date: Mon, 20 Oct 2003 16:57:01 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test8: lockd fails for non-root users
Message-ID: <20031020165701.B13180@osdlab.pdx.osdl.net>
References: <20031020123510.GA2954@skinner.hem.za.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20031020123510.GA2954@skinner.hem.za.org>; from mikaelmagnusson@tjohoo.se on Mon, Oct 20, 2003 at 02:35:10PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Mikael Magnusson (mikaelmagnusson@tjohoo.se) wrote:
> 1. Summary:
> 2.6.0-test8: lockd fails for non-root users

Confirmed this is a bug in the interaction between the capabilities bits
and the default security module.  In near term, the simple way to handle
this is:

# modprobe capability

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
