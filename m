Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbWJ0Ue0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbWJ0Ue0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 16:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbWJ0Ue0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 16:34:26 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:1628 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751313AbWJ0UeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 16:34:25 -0400
Message-ID: <45426D3F.3040304@oracle.com>
Date: Fri, 27 Oct 2006 13:34:07 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Jeff Moyer <jmoyer@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dio: lock refcount operations
References: <20061027181735.18631.43565.sendpatchset@tetsuo.zabbo.net> <x49fyd9v9sy.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49fyd9v9sy.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I don't believe that this can happen.

Yeah, I think my brain made the leap to spurious wake-ups from hashed
wait queues.  Which aren't being used :).  As long as it's a private
wait queue and sleeps and sleeps with UNINTERRUPTIBLE it seems ok.

Do you think the cleanup shouldn't be done?  It seems easier to
understand after the patch, and makes dio_await_one() pretty darn
straight forward.

- z
