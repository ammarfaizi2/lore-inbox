Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269597AbUICJgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269597AbUICJgb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 05:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269464AbUICJg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 05:36:29 -0400
Received: from plam.fujitsu-siemens.com ([217.115.66.9]:59184 "EHLO
	plam.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S269616AbUICJck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 05:32:40 -0400
Message-ID: <41383E61.7000900@fujitsu-siemens.com>
Date: Fri, 03 Sep 2004 11:50:25 +0200
From: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Organization: Fujitsu Siemens Computers
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm2
References: <2zaWg-4Yj-1@gated-at.bofh.it> <2zxzF-4pS-19@gated-at.bofh.it> <2zxJk-4vm-29@gated-at.bofh.it>
In-Reply-To: <2zxJk-4vm-29@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

> -	if (!test_bit(bit, word))
> +	if (!test_and_set_bit(bit, word))

This one fixed a nasty buffer locking race I saw with 2.6.9-rc1-mm2.
Thanks a lot!

Regards,
Martin
