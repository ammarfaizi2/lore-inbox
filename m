Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312193AbSCREMD>; Sun, 17 Mar 2002 23:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312194AbSCRELy>; Sun, 17 Mar 2002 23:11:54 -0500
Received: from pizda.ninka.net ([216.101.162.242]:55482 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S312193AbSCRELk>;
	Sun, 17 Mar 2002 23:11:40 -0500
Date: Sun, 17 Mar 2002 20:08:28 -0800 (PST)
Message-Id: <20020317.200828.64296429.davem@redhat.com>
To: rusty@rustcorp.com.au
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        rgooch@ras.ucalgary.ca
Subject: Re: bit ops on unsigned long? 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E16m4YD-0004af-00@wagner.rustcorp.com.au>
In-Reply-To: <Pine.LNX.4.33.0203151656320.1379-100000@home.transmeta.com>
	<E16m4YD-0004af-00@wagner.rustcorp.com.au>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rusty Russell <rusty@rustcorp.com.au>
   Date: Sat, 16 Mar 2002 14:08:08 +1100

   +#ifdef CONFIG_PREEMPT
    	/* Set the preempt count _outside_ the spinlocks! */
    	idle->thread_info->preempt_count = (idle->lock_depth >= 0);
   +#endif

This part of your patch has to go.  Every port must
provide the preempt_count member of thread_info regardless
of the CONFIG_PREEMPT setting.
