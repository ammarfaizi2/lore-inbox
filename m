Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269311AbUI3QB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269311AbUI3QB0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 12:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269312AbUI3QBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 12:01:25 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:6621 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S269311AbUI3QAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 12:00:51 -0400
Message-ID: <415C2DA4.5080102@colorfullife.com>
Date: Thu, 30 Sep 2004 18:00:36 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Tweedie <sct@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Patch 0/10]: Cleanup online reservations for 2.6.9-rc2-mm4.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sct wrote:

>Locking
>is minimised: the impact on the hot path consists of nothing more than
>an smp_rmb() before we test sb->s_groups_count.  That's a noop on x86,
>
No, wrong way around:
wmb() is empty. rmb() is either lfence or a locked dummy instruction.

--
    Manfred

