Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750847AbWGQPbB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbWGQPbB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 11:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbWGQPbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 11:31:01 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:42685 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1750847AbWGQPbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 11:31:00 -0400
Message-ID: <44BBAD28.6040701@steeleye.com>
Date: Mon, 17 Jul 2006 11:30:48 -0400
From: Paul Clements <paul.clements@steeleye.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Michal Feix <michal@feix.cz>, akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nbd: Check magic before doing anything else
References: <44BA39E5.7060002@feix.cz>
In-Reply-To: <44BA39E5.7060002@feix.cz>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Feix wrote:
> We should check magic sequence in reply packet before trying to find
> request with it's request handle. This also solves the problem with
> "Unexpected reply" message beeing logged, when packet with invalid magic
> is received.

Right. Again, we can't return NULL after pulling the request off the 
queue, so we better do this check first.

Andrew, these two look good to me.

Thanks,
Paul
