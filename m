Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268116AbUHKQgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268116AbUHKQgy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 12:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268108AbUHKQgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 12:36:52 -0400
Received: from zero.aec.at ([193.170.194.10]:12037 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S268128AbUHKQgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 12:36:22 -0400
To: prasanna@in.ibm.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [1/4] Exceptions Notifier patch
References: <2s3ZC-7Zq-15@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Wed, 11 Aug 2004 18:36:16 +0200
In-Reply-To: <2s3ZC-7Zq-15@gated-at.bofh.it> (Prasanna S. Panchamukhi's
 message of "Wed, 11 Aug 2004 18:20:08 +0200")
Message-ID: <m3d61x4oov.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prasanna S Panchamukhi <prasanna@in.ibm.com> writes:

Just some cosmetical comments.

>  
> +EXPORT_SYMBOL(register_die_chain_notify);

Please name it "register_die_notifier" 

>  
>  static int kstack_depth_to_print = 24;
> +struct notifier_block *i386die_chain;
> +static DECLARE_MUTEX(i386die_chain_mutex);

s/i386//

I don't know why you made this a mutex, a spinlock would 
be fine too. But that's a minor issue.

Rest looks ok.

-Andi

