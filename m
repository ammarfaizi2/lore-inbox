Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbUCAWgr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 17:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbUCAWgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 17:36:47 -0500
Received: from ns.suse.de ([195.135.220.2]:47792 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261461AbUCAWgq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 17:36:46 -0500
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: per-cpu blk_plug_list
References: <B05667366EE6204181EABE9C1B1C0EB501F2AB4C@scsmsx401.sc.intel.com>
From: Andi Kleen <ak@suse.de>
Date: 01 Mar 2004 23:36:44 +0100
In-Reply-To: <B05667366EE6204181EABE9C1B1C0EB501F2AB4C@scsmsx401.sc.intel.com.suse.lists.linux.kernel>
Message-ID: <p73r7wcyz2b.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What happens when a process that started a plug on one CPU switches CPUs
before unplugging?

I don't see any mechanism in your patch to make sure the queue on the previous
CPU is flushed too. It could be delayed for a long time.

-Andi
