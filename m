Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937369AbWLDUXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937369AbWLDUXL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 15:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937370AbWLDUXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 15:23:10 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:61381 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937369AbWLDUXI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 15:23:08 -0500
Message-ID: <45748388.9030400@oracle.com>
Date: Mon, 04 Dec 2006 12:22:32 -0800
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] kill pointless ki_nbytes assignment in aio_setup_single_vector
References: <000101c717c2$0fe26ce0$2589030a@amr.corp.intel.com>
In-Reply-To: <000101c717c2$0fe26ce0$2589030a@amr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W wrote:
> io_submit_one assigns ki_left = ki_nbytes = iocb->aio_nbytes, then
> calls down to aio_setup_iocb, then to aio_setup_single_vector. In there,
> ki_nbytes is reassigned to the same value it got two call stack above it.
> There is no need to do so.
> 
> Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>

That seems to be the case, indeed.

Acked-by: Zach Brown <zach.brown@oracle.com>

- z
