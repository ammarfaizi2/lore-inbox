Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267841AbUJDIoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267841AbUJDIoL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 04:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267852AbUJDIoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 04:44:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:15751 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267841AbUJDIoH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 04:44:07 -0400
Date: Mon, 4 Oct 2004 01:41:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: shobhit@calsoftinc.com
Cc: linux-kernel@vger.kernel.org, geoff@linux.intel.com, mingo@elte.hu
Subject: Re: [RFC] [PATCH] Performance of del_single_shot_timer_sync
Message-Id: <20041004014147.776e4ecf.akpm@osdl.org>
In-Reply-To: <1096874675.11717.33.camel@kuber>
References: <1096874675.11717.33.camel@kuber>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

shobhit dayal <shobhit@calsoftinc.com> wrote:
>
> I tried Geoff's patch and it does seem to improve performance.

By how much?  (CPU load, overall runtime, etc)

It's a bit odd to have an expired-timer-intensive workload.  Presumably
postgres has some short-lived nanosleep or select-based polling loop in
there which isn't doing much.
