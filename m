Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262012AbVAJAKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbVAJAKl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 19:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbVAJAKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 19:10:40 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:5833 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262012AbVAJAII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 19:08:08 -0500
Subject: Re: PROBLEM: ide-cd in 2.6.8-2.6.10 and 2.4.26-2.4.28 high cpu use
	with dma
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hikaru1@verizon.net
Cc: axboe@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050109123028.GA12753@roll>
References: <20050109105201.GB12497@roll> <20050109105418.GD12497@roll>
	 <20050109123028.GA12753@roll>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105278277.12004.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 09 Jan 2005 23:01:22 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-01-09 at 12:30, Hikaru1@verizon.net wrote:
> A minor mistake. I forgot to state explicitly that the problem only appears
> with writing audio cds. Writing data cds does not cause problems.

It sets the required alignment of buffers for DMA. The 2.6.10 code is
correct, the question is who is feeding unaligned buffers to the driver
layer - the kernel or the SG layer. Which burning interface are you
using  - /dev/sg  (ie dev=1,0,0) or /dev/hd*  (dev=/dev/hdc etc)


