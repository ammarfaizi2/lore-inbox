Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262101AbUFVNo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbUFVNo3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 09:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263663AbUFVNo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 09:44:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8415 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262101AbUFVNo1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 09:44:27 -0400
Message-ID: <40D837AB.2000104@pobox.com>
Date: Tue, 22 Jun 2004 09:44:11 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new device support for forcedeth.c fourth try
References: <29ACK-1wm-17@gated-at.bofh.it> <29B5I-1QM-3@gated-at.bofh.it>	<29QeD-5kp-11@gated-at.bofh.it> <m3llifevr8.fsf@averell.firstfloor.org>
In-Reply-To: <m3llifevr8.fsf@averell.firstfloor.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net> writes:
> 
> 
>>Known Bug: You will get a "bad: scheduling while atomic" message because
>>of the msleep(500) in PHY reset.
>>
>>Any suggestions how I can avoid this message? Using mdelay(500) has its
>>share of problems too, because it will cause lost time.
> 
> 
> Use schedule_work() to push it into a worker thread.


Agreed.  This is what I am moving net drivers to, for slow path stuff 
like chip reset or twiddling the phy.

	Jeff


