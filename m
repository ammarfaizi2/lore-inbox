Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265558AbUANK2M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 05:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265461AbUANK2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 05:28:12 -0500
Received: from denise.shiny.it ([194.20.232.1]:37031 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id S265439AbUANK1y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 05:27:54 -0500
Date: Wed, 14 Jan 2004 11:27:51 +0100 (CET)
From: Giuliano Pochini <pochini@denise.shiny.it>
To: Haakon Riiser <hakonrk@ulrik.uio.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: Busy-wait delay in qmail 1.03 after upgrading to Linux 2.6
In-Reply-To: <20040113234611.GA558@s.chello.no>
Message-ID: <Pine.LNX.4.58.0401141123460.25000@denise.shiny.it>
References: <20040113210923.GA955@s.chello.no> <20040113135152.3ed26b85.akpm@osdl.org>
 <20040113232624.GA302@s.chello.no> <20040113234611.GA558@s.chello.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 14 Jan 2004, Haakon Riiser wrote:
> For example, another problem I encountered while
> upgrading to 2.6 was that disk intensive jobs, such as updating
> the slocate database, made ascpu report 100% CPU usage.  I just
> ran top (procps 2.0.16) beside it, and it reported approximately
> 10% CPU usage, which is no more than 2.4 used.

It makes sense, since HZ is 10 times higher in 2.6. Did you
recompile ascpu ? Check if ascpu assumes HZ is 100. In that
case it may overstimate the cpu time by a factor 10.


--
Giuliano.
