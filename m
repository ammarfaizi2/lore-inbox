Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263091AbTJEMYk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 08:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263092AbTJEMYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 08:24:40 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:56192 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263091AbTJEMYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 08:24:38 -0400
Date: Sun, 5 Oct 2003 13:25:10 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200310051225.h95CPA2P000439@81-2-122-30.bradfords.org.uk>
To: Hacksaw <hacksaw@hacksaw.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200310051157.h95BvwvA004385@habitrail.home.fools-errant.com>
References: <200310051157.h95BvwvA004385@habitrail.home.fools-errant.com>
Subject: Re: swap and 2.4.20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Hacksaw <hacksaw@hacksaw.org>:

> What is the current state of the need for swap on a linux kernel, 2.4.20 in 
> specific. Does it need *any*, given some reasonable amount of RAM? What 
> constitutes a reasonable of RAM?

It depends almost entirely on your application.

> My recent experience suggest none is needed.

That's quite possible.

My 'standard' desktop machines run swapless with 512 MB RAM.

It is often said that adding too much swap does little or no harm, and
as disk space is cheap these days, it's better to over allocate it
rather than run out.

This is not always true.  Over-allocating swap space can degrade
performance and waste a lot of time in some cases.

For example,  I know an ISP who allocated more swap than needed on
their customer webserver.  Despite my advice, it wasn't reconfigured,
and one day a runaway process started using all the swap and the
machine became almost completely unresponsive.  Somebody spent hours
going to the datacentre and back just to reboot it.

John.
