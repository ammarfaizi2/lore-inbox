Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbTIOHs4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 03:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbTIOHs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 03:48:56 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:27298 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262048AbTIOHsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 03:48:54 -0400
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1030914233016.16842A-100000@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1030914233016.16842A-100000@gatekeeper.tmr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063611959.2742.4.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Mon, 15 Sep 2003 08:45:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-09-15 at 04:55, Bill Davidsen wrote:
> 1 - the code is not needed for Athlon, prefetch is turned off on broken
>     CPUs now. A generic kernel runs fine on Athlon.

That disable you talk about is bloat. It also trashes the performance of
PIV boxes. In fact I checked out of interest - the disable hack
currently being used is adding *over* 300 bytes to my kernel as its
inlined repeatedly. So its larger, and it ruins performance for all
processors.

You also need it for userspace prefetch fault fixup for a kernel without
CONFIG_MK7 to run stuff perfectly on Athlon.


