Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266274AbUIMHeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266274AbUIMHeq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 03:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266289AbUIMHeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 03:34:46 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:215 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266274AbUIMHep (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 03:34:45 -0400
Date: Mon, 13 Sep 2004 09:32:59 +0200
From: Jens Axboe <axboe@suse.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andrea Arcangeli <andrea@novell.com>, Ingo Molnar <mingo@elte.hu>,
       Chris Wedgwood <cw@f00f.org>, Arjan van de Ven <arjanv@redhat.com>,
       Hugh Dickins <hugh@veritas.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
Message-ID: <20040913073259.GF2326@suse.de>
References: <20040910151538.GA24434@devserv.devel.redhat.com> <20040910152852.GC15643@x30.random> <20040910153421.GD24434@devserv.devel.redhat.com> <1095016687.1306.667.camel@krustophenia.net> <20040912192515.GA8165@taniwha.stupidest.org> <20040912193542.GB28791@elte.hu> <20040912203308.GA3049@dualathlon.random> <1095025000.22893.52.camel@krustophenia.net> <20040912220720.GC3049@dualathlon.random> <1095027951.22893.69.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095027951.22893.69.camel@krustophenia.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12 2004, Lee Revell wrote:
> I am still unsure why the IDE i/o completion is the one place that
> breaks the assumption that hardirq handlers execute quickly.

I'm not sure why you think so. You also mention IDE as being the
'glaring exception' and it's definitely wrong. Most drivers run the
completion from hardirq context, SCSI is the exception since it does it
defers the completion to softirq context.

-- 
Jens Axboe

