Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbUK1P5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbUK1P5B (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 10:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbUK1P5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 10:57:01 -0500
Received: from holomorphy.com ([207.189.100.168]:22918 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261502AbUK1Pzx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 10:55:53 -0500
Date: Sun, 28 Nov 2004 07:55:46 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/2] rcu: eliminate rcu_data.last_qsctr
Message-ID: <20041128155546.GC2714@holomorphy.com>
References: <41A9E98F.209C59B0@tv-sign.ru> <20041128144346.GB2714@holomorphy.com> <41A9E857.7040100@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41A9E857.7040100@colorfullife.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> That might work if there were only 1 cpu. The local cpu owns ->qsctr,
>> ->last_qsctr is stored and loaded by remote cpus under locks.

On Sun, Nov 28, 2004 at 04:01:43PM +0100, Manfred Spraul wrote:
> No. The whole rcu_data structure is cpu-local, it's never accessed from 
> remote cpus [except during hotunplug]. It doesn't even contain a lock.

Looks like if I ever knew what was going on in rcupdate.c I forgot it.
Back to damage control for ongoing catastrophes for me.


-- wli
