Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263033AbUDUO0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263033AbUDUO0X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 10:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbUDUO0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 10:26:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44178 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263033AbUDUO0V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 10:26:21 -0400
Subject: Re: 2.4.26, RAID1 + ext3fs oops(es)
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Rui Sousa <rui.sousa@laposte.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <1082556296.6911.39.camel@sophia-sousar2-1.nice.mindspeed.com>
References: <1082556296.6911.39.camel@sophia-sousar2-1.nice.mindspeed.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1082557576.2060.19.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 21 Apr 2004 15:26:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2004-04-21 at 15:05, Rui Sousa wrote:

> I'm seeing frequent oopses when using a combination of RAID1 plus
> ext3fs.

The log is full of errors like

        EIP:    0010:[prune_dcache+24/320]    Not tainted
        
Unfortunately, dcache corruptions like that are most often a sign of bad
hardware, usually memory.  I'd recommend an overnight memtest86 run as
the first step towards diagnosing the problem.

Cheers,
 Stephen

