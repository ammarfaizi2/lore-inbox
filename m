Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269602AbTHSJmN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 05:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269619AbTHSJmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 05:42:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:51123 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269602AbTHSJmL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 05:42:11 -0400
Date: Tue, 19 Aug 2003 02:43:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: jamagallon@able.es, vda@port.imtp.ilyichevsk.odessa.ua,
       russo.lutions@verizon.net, linux-kernel@vger.kernel.org
Subject: Re: cache limit
Message-Id: <20030819024302.1899cde3.akpm@osdl.org>
In-Reply-To: <20030819092831.GA9424@werewolf.able.es>
References: <3F41AA15.1020802@verizon.net>
	<200308190533.h7J5XoL06419@Port.imtp.ilyichevsk.odessa.ua>
	<20030818232024.20c16d1f.akpm@osdl.org>
	<20030819090541.GA9038@werewolf.able.es>
	<20030819021617.392f24f4.akpm@osdl.org>
	<20030819092831.GA9424@werewolf.able.es>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" <jamagallon@able.es> wrote:
>
> 
> So could O_STREAMING be included in 2.4, and let people do things like

Sounds fairly ugh, actually.  It might be better to just implement
fadvise().

O_STREAMING is really designed for large streaming writes; the current
implementation only performs invalidation after each megabyte of I/O, so it
would fail to do anything at all in the lots-of-medium-size-files case
such as rsync.

Or use 2.6.  It will take a while for the feature to usefully propagate into
applications anyway...

