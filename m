Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291320AbSBMDYi>; Tue, 12 Feb 2002 22:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291321AbSBMDY1>; Tue, 12 Feb 2002 22:24:27 -0500
Received: from holomorphy.com ([216.36.33.161]:18853 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S291320AbSBMDYQ>;
	Tue, 12 Feb 2002 22:24:16 -0500
Date: Tue, 12 Feb 2002 19:24:02 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Robert Jameson <rj@open-net.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: unresolved symbols ipt_owner.o with 2.4.18-pre9 with mjc patch
Message-ID: <20020213032402.GC3588@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Robert Jameson <rj@open-net.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020212214016.7fa188c3.rj@open-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020212214016.7fa188c3.rj@open-net.org>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2002 at 09:40:16PM -0500, Robert Jameson wrote:
> Is there a fix for the unresolved symbols with ipt_owner.o with
> 2.4.18-pre9 + mjc's patch, i don't know if this is 2.4.18-pre9 specific or
> if its a mjc error, either way, heres the error,

Does this help?

--- linux-virgin/kernel/fork.c  Tue Jan 29 18:28:26 2002
+++ linux-wli/kernel/fork.c Tue Jan 29 22:42:27 2002
@@ -36,6 +36,9 @@
 unsigned long pidhash_size;
 unsigned long pidhash_bits;
 list_t *pidhash;
+EXPORT_SYMBOL(pidhash);
+EXPORT_SYMBOL(pidhash_bits);
+EXPORT_SYMBOL(pidhash_size);
 
 rwlock_t tasklist_lock __cacheline_aligned = RW_LOCK_UNLOCKED;  /* outer */
 
