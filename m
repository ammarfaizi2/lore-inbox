Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265373AbUFHXE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265373AbUFHXE2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 19:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265378AbUFHXE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 19:04:28 -0400
Received: from gizmo11bw.bigpond.com ([144.140.70.21]:58586 "HELO
	gizmo11bw.bigpond.com") by vger.kernel.org with SMTP
	id S265373AbUFHXE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 19:04:26 -0400
Message-ID: <40C645F7.6070704@bigpond.net.au>
Date: Wed, 09 Jun 2004 09:04:23 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [PATCH] staircase scheduler v6.4 for 2.6.7-rc3
References: <200406090023.54421.kernel@kolivas.org>
In-Reply-To: <200406090023.54421.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Here is an updated full version of the staircase scheduler (not attached for 
> brevity of email):
> 
> http://ck.kolivas.org/patches/2.6/2.6.7-rc3/patch-2.6.7-rc3-s6.4
> 
> 25 files changed, 264 insertions(+), 545 deletions(-)

There was no need to add the extra overhead of a flag to indicate that a 
task was queued for scheduling.  Testing whether run_list is empty 
achieves the same thing as reliably as the old array == NULL test did.

-- 
Dr Peter Williams                                pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

