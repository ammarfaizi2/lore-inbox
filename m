Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262967AbUKYElI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262967AbUKYElI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 23:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262969AbUKYElI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 23:41:08 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:41108 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262967AbUKYElH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 23:41:07 -0500
Subject: Re: [PATCH] Work around for periodic do_gettimeofday hang
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: arjan@infradead.org, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20041124203349.7982efb7.akpm@osdl.org>
References: <1101314988.1714.194.camel@mulgrave>
	<1101323621.2811.24.camel@laptop.fenrus.org>
	<1101356864.4007.35.camel@mulgrave>  <20041124203349.7982efb7.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 24 Nov 2004 22:40:51 -0600
Message-Id: <1101357657.5428.39.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-24 at 22:33, Andrew Morton wrote:
> Silly question: how come do_gettimeofday() is hanging?

That's what I don't know.  like I said, the xtime seqlock seemed to be
implicated, but I've never managed to trace it down.

I also notice that under heavy load the system starts to lose time (at
least according to ntp).  I suspect there's something wrong with the PIT
timer routine (since that's what voyager has to use) for adding lost
ticks.

James


