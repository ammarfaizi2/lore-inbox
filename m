Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266276AbTGHAW2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 20:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266277AbTGHAW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 20:22:28 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:54156 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S266276AbTGHAW1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 20:22:27 -0400
Date: Tue, 8 Jul 2003 01:36:56 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: syscall __NR_mmap2
Message-ID: <20030708003656.GC12127@mail.jlokier.co.uk>
References: <Pine.LNX.4.53.0307071655470.22074@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0307071655470.22074@chaos>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> mmap2(0xb8000, 8192, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_FIXED, 3, 0xb8000) = 0xb8000

You meant to write:

	mmap2(0xb8000, 8192, PROT_READ|PROT_WRITE,
	      MAP_SHARED|MAP_FIXED, 3, 0xb8000 >> 12);

The offset argument to mmap2 is divided by PAGE_SIZE.
That is the whole point of mmap2 :)

-- Jamie
