Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264452AbTIIVDW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 17:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264446AbTIIVDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 17:03:21 -0400
Received: from ivoti.terra.com.br ([200.176.3.20]:52454 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP id S264452AbTIIVDQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 17:03:16 -0400
Message-ID: <3F5E364E.2040409@terra.com.br>
Date: Tue, 09 Sep 2003 17:21:34 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Missing memory barrier on net/core/dev.c
References: <3F5E14D7.9030809@terra.com.br> <20030909124635.3c0d522b.davem@redhat.com>
In-Reply-To: <20030909124635.3c0d522b.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

David S. Miller wrote:
> On Tue, 09 Sep 2003 14:58:47 -0300
> Felipe W Damasio <felipewd@terra.com.br> wrote:
> 
> 
>>	I *think* net/core/dev.c is missing a mb() before calling 
>>schedule_timoeut.
> 
> I have another patch in my queue from Andrew Morton that
> removes the TASK_RUNNING setting altogether, schedule_timeout()
> always returns with the task in that state.

	Ok, although that was not the main point of the patch :)

	What about the "set_current_state" before calling schedule_timeout. 
Isn't that mb() needed?

	Cheers,

Felipe

