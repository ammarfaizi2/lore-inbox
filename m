Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265930AbUGNVu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265930AbUGNVu1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 17:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265920AbUGNVu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 17:50:27 -0400
Received: from mail1.fw-sj.sony.com ([160.33.82.68]:30367 "EHLO
	mail1.fw-sj.sony.com") by vger.kernel.org with ESMTP
	id S265930AbUGNVuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 17:50:12 -0400
Message-ID: <40F5AB57.6080507@am.sony.com>
Date: Wed, 14 Jul 2004 14:53:27 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc1-mm1
References: <20040713182559.7534e46d.akpm@osdl.org>
In-Reply-To: <20040713182559.7534e46d.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> +preset-loops_per_jiffy-for-faster-booting.patch
> 
>  Add the "lpj=" kernel boot option

I tested this...
   With HZ=1000:
     - normal boot: calibrate_delay() took 23 milliseconds
     - specifying lpj=xxx: calibrate_delay() took 43 microseconds.
   With HZ=100:
     - normal boot: calibrate_delay() took 264 milliseconds
     - specifying lpj=xxx: calibrate_delay() took 43 microseconds.

No adverse behaviour was observed.

This will be a big improvement for embedded folks.
Thanks,
   -- Tim

=============================
Tim Bird
Architecture Group Co-Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
E-mail: tim.bird@am.sony.com
=============================
