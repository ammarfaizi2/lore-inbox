Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265261AbTFROd4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 10:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265167AbTFROdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 10:33:55 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:23003 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S265261AbTFROdy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 10:33:54 -0400
Date: Wed, 18 Jun 2003 09:47:44 -0500
Subject: Re: [patch] input: Fix CLOCK_TICK_RATE usage ...  [8/13]
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linux-kernel@vger.kernel.org
To: davidm@hpl.hp.com
From: Hollis Blanchard <hollisb@us.ibm.com>
In-Reply-To: <16111.41748.667166.867915@napali.hpl.hp.com>
Message-Id: <D1BF5DC4-A19B-11D7-A24A-000A95A0560C@us.ibm.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, Jun 17, 2003, at 18:24 US/Central, David Mosberger wrote:
>  #ifdef CONFIG_LEGACY_HW
>  # define PIT_FREQ	1193182
>  # define LATCH		((CLOCK_TICK_RATE + HZ/2) / HZ)
>  #endif
>
> This way, machines that support legacy hardware can define
> CONFIG_LEGACY_HW and on others, the macro can be left undefined, so
> that any attempt to compile drivers requiring legacy hw would fail to
> compile upfront (much better than accessing random ports!).

Is "having legacy hardware" an all-or-nothing condition for you? If 
not, a CONFIG_LEGACY_PIT might be more appropriate...

-- 
Hollis Blanchard
IBM Linux Technology Center

