Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265581AbUBQBlh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 20:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265714AbUBQBle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 20:41:34 -0500
Received: from shells.hardanger.net ([209.113.172.35]:15877 "EHLO
	server.bohemians.org") by vger.kernel.org with ESMTP
	id S265581AbUBQBld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 20:41:33 -0500
Date: Mon, 16 Feb 2004 20:41:23 -0500
From: Kristian =?iso-8859-1?Q?Lyngst=F8l?= <nesquik@bohemians.org>
To: Christian =?iso-8859-1?Q?K=F6gler?= 
	<christian.koegler@unibw-muenchen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: tasklets vs. workqueues
Message-ID: <20040217014123.GA16165@bohemians.org>
References: <403117FF.1080200@unibw-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <403117FF.1080200@unibw-muenchen.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 16, 2004 at 08:20:31PM +0100, Christian Kögler wrote:
> When should I use tasklets and when should I user workqueues?
> What are the differences?

To quote "Linux Kernel Development" (Which I am currently reading):

Work queues defer work into a kernel thread-the work always runs in process
context. Most importantly, work queues are schedulable and can therefore sleep.

Normally, there is little decision between work queues or sotftirqs/tasklets.
If the deferred work need to sleep, work queues are used. If the deferred 
work need not sleepa, softirqs or tasklets are used.

[end quote]

Hope this helped :)

-- 
Med vennlig hilsen
Kristian Lyngstøl
