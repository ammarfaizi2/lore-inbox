Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264569AbUDVRIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264569AbUDVRIJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 13:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264573AbUDVRIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 13:08:09 -0400
Received: from fmr99.intel.com ([192.55.52.32]:30680 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S264569AbUDVRIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 13:08:05 -0400
Subject: Re: ACPI suspend to RAM weirdness
From: Len Brown <len.brown@intel.com>
To: jason@stdbev.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F9797@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F9797@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1082653671.16332.339.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 22 Apr 2004 13:07:51 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-22 at 12:24, Jason Munro wrote:
> Hello all,
>    I can sucessfully suspend with 'echo 3 > /proc/acpi/sleep' on my
> Toshiba
> Satellite 1410-S173. It also wakes up fine, except after waking it
> jumps to
> init 0 and shuts down. It's been this way with every kernel I have
> tried
> since 2.6.4. I know it worked with 2.6.1 but I'm not sure exactly at
> what
> point between that and 2.6.4 it changed, or even if this is a
> userspace or
> kernel issue. Yesterday I tried with 2.6.6-rc2 and rc2-mm1 and it
> still
> behaves the same.

We have some event/wakeup GPE weirdness lately.
You might try working around it by shutting down acpid
before you suspend -- it may be processing your wakeup
power button event as a signal to shut down.

-Len


