Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbVE3LJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbVE3LJR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 07:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261441AbVE3LJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 07:09:01 -0400
Received: from one.firstfloor.org ([213.235.205.2]:49042 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261433AbVE3LG6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 07:06:58 -0400
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: john cooper <john.cooper@timesys.com>, linux-kernel@vger.kernel.org
Subject: Re: spinaphore conceptual draft
References: <934f64a205052715315c21d722@mail.gmail.com>
	<A53A981B-98F9-42EC-8939-60A528FEC34E@mac.com>
From: Andi Kleen <ak@muc.de>
Date: Mon, 30 May 2005 13:06:57 +0200
In-Reply-To: <A53A981B-98F9-42EC-8939-60A528FEC34E@mac.com> (Kyle Moffett's
 message of "Fri, 27 May 2005 21:04:37 -0400")
Message-ID: <m1r7fpvupa.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett <mrmacman_g4@mac.com> writes:

>          if (unlikely(CONFIG_SPINAPHORE_CONTEXT_SWITCH <
>                  ( queued*atomic_get(&sph->hold_time) -
>                    fast_monotonic_count() - start_time

On many architectures (including popular ones like AMD x86-64) 
there is no reliable fast monotonic (1) count unfortunately - except perhaps
jiffies, but that would be far to coarse grained for your purpose.

-Andi

(1) reliable fast monotonic - chose any two instead. 
