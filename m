Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264463AbTFKUjX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 16:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264444AbTFKUhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 16:37:17 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:19331 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264533AbTFKUgi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 16:36:38 -0400
Subject: Re: [PATCH] New x86_64 time code for 2.5.70
From: john stultz <johnstul@us.ibm.com>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: Andi Kleen <ak@suse.de>, vojtech@suse.cz, discuss@x86-64.org,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1055357432.17154.77.camel@serpentine.internal.keyresearch.com>
References: <1055357432.17154.77.camel@serpentine.internal.keyresearch.com>
Content-Type: text/plain
Organization: 
Message-Id: <1055364287.18643.59.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 11 Jun 2003 13:44:47 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-11 at 11:50, Bryan O'Sullivan wrote:
> I've forward-ported Vojtech's time code from 2.4, fixing some locking
> along the way.  The new code supports using the AMD8111 HPET for time
> calculations.  It also works stably with the PIT/TSC on every boot,
> which is the source of the time problems in current 2.5.

Oh drat, you beat me to it! I've been working on the very same thing.
This is very much needed, so thanks for doing this.

> Right now, the only known problem is with the fixup of jiffies if a
> timer interrupt is lost, which I've hence turned off.  There's
> preliminary support for using HPET for the gettimeofday vsyscall, but
> since vsyscalls are disabled on x86-64 for now, that's obviously
> untested.

I'll start testing your patch and I'll see if I can't fixup the lost
tick compensation.

thanks!
-john

