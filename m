Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030215AbWJCP33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbWJCP33 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 11:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030220AbWJCP32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 11:29:28 -0400
Received: from brick.kernel.dk ([62.242.22.158]:54806 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1030215AbWJCP31 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 11:29:27 -0400
Date: Tue, 3 Oct 2006 17:29:00 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Thomas Maier <balagi@justmail.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "petero2@telia.com" <petero2@telia.com>,
       "akpm@osdl.org" <akpm@osdl.org>
Subject: Re: [PATCH 8/11] 2.6.18-mm3 pktcdvd: bio write congestion control
Message-ID: <20061003152859.GQ7778@kernel.dk>
References: <op.tguqidxpiudtyh@master>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op.tguqidxpiudtyh@master>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03 2006, Thomas Maier wrote:
> Hello,
> 
> this patch adds the ability to control the size of the drivers
> bio write queue.

imho, this should not be a configuration option. The driver is perfectly
capable of sizing this queue appropriately (determined by the device)
without user interaction. Basically the option just needs to prevent the
system from falling over, just choose some low sane value.

-- 
Jens Axboe

