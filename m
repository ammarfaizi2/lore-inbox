Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbTITCC3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 22:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbTITCC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 22:02:28 -0400
Received: from zero.aec.at ([193.170.194.10]:33288 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261262AbTITCC2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 22:02:28 -0400
To: "Villacis, Juan" <juan.villacis@intel.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.x] additional kernel event notifications
From: Andi Kleen <ak@muc.de>
Date: Sat, 20 Sep 2003 04:02:08 +0200
In-Reply-To: <xAZi.1DR.1@gated-at.bofh.it> ("Villacis, Juan"'s message of
 "Fri, 19 Sep 2003 23:30:09 +0200")
Message-ID: <m3llskz07z.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <xAZi.1DR.1@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Villacis, Juan" <juan.villacis@intel.com> writes:

> The current event notifications used by tools like Oprofile, while quite
> useful, are not sufficient.  The additional event notifications we
> propose can provide a more complete picture for performance tuning on
> Linux, particularly for dynamically generated code (such as found in
> Java).  

Can you explain why profiling dynamically generated code needs kernel
support? The kernel should not know anything about this.

The original oprofile patch also added similar hooks, but they were
not merged. Instead the "dcookies" mechanism was added to assign samples to 
specific executables. Why can't you use the same mechanism? 

There is not more information in the kernel than what dcookies 
already provide.

-Andi
