Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263567AbUDPSnX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 14:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263599AbUDPSnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 14:43:22 -0400
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:54950 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S263567AbUDPSnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 14:43:14 -0400
Message-ID: <4080297A.1090002@pacbell.net>
Date: Fri, 16 Apr 2004 11:44:10 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Colin Leroy <colin@colino.net>
CC: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] 2.6.6-rc1: cdc-acm still (differently) broken
References: <20040415201117.11524f63@jack.colino.net>	<407EDA4A.2070509@pacbell.net>	<20040415212334.4a568c5a@jack.colino.net>	<407EE9A5.3020305@pacbell.net> <20040416122415.6f532584@jack.colino.net>
In-Reply-To: <20040416122415.6f532584@jack.colino.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

> Here's another patch, which fixes the leak. It also fixes the
> FIXME, by looking at all interfaces to find the data one. Is it correct ?

It's looking better, but what I'd rather see is code scanning the
CDC descriptors (see "usbnet").  The deal is that there's actually
no guarantee that there's only one data interface, although that
seems to hold true for many current products.

But unless you're interested in finishing a much-needed rewrite
of that cdc-acm probe() code, this might be a good place to stop.
(Or at least pause!)

- Dave



