Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266253AbUARHo5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 02:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266259AbUARHo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 02:44:57 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:10408 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S266253AbUARHo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 02:44:56 -0500
Message-ID: <400A396B.4090207@colorfullife.com>
Date: Sun, 18 Jan 2004 08:44:43 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>, dwmw2@infradead.org,
       viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [RFC] kill sleep_on
References: <40098251.2040009@colorfullife.com>	<1074367701.9965.2.camel@imladris.demon.co.uk>	<20040117201000.GL21151@parcelfarce.linux.theplanet.co.uk>	<1074383111.9965.4.camel@imladris.demon.co.uk>	<20040117224139.5585fb9c.akpm@osdl.org>	<1074409074.1569.12.camel@nidelv.trondhjem.org> <20040117233618.094c9d22.akpm@osdl.org>
In-Reply-To: <20040117233618.094c9d22.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>That's quite a lot of contention on the lock_kernel() in remote_llseek().
>  
>
What about switching to generic_file_llseek, at least for files? The 
only references to f_pos are in filldir/readdir.

--
    Manfred

