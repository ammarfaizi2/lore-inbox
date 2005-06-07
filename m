Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261868AbVFGOZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbVFGOZO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 10:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbVFGOZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 10:25:14 -0400
Received: from unicorn.rentec.com ([216.223.240.9]:31997 "EHLO
	unicorn.rentec.com") by vger.kernel.org with ESMTP id S261868AbVFGOZJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 10:25:09 -0400
X-Rentec: external
Message-ID: <42A5AE2D.6020100@rentec.com>
Date: Tue, 07 Jun 2005 10:24:45 -0400
From: Wolfgang Wander <wwc@rentec.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: 2.6.12-rc6-mm1
References: <20050607042931.23f8f8e0.akpm@osdl.org>
In-Reply-To: <20050607042931.23f8f8e0.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Logged: Logged by unicorn.rentec.com as j57EOkgg024486 at Tue Jun  7 10:24:48 2005
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> +avoiding-mmap-fragmentation-revert-unneeded-64-bit-changes-vs-x86_64-task_size-fixes-for-compatibility-mode-processes.patch

As a heads-up.

This one breaks the fragmentation reduction patch in 32 bit emulation mode.
Our test case shows the standard 17 fragmented regions in /proc/self/maps (as in
the 2.6 standard kernel) vs the 2 regions in 2.6.12-rc5-mm2 (and before).

Somehow the new way of detecting 32 bit remulation mode seems to fail here.

I'll try to figure out a fix.

               Wolfgang



