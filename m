Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265236AbUBENbc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 08:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265238AbUBENbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 08:31:32 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:47239 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S265236AbUBENba
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 08:31:30 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16418.17841.293641.878787@laputa.namesys.com>
Date: Thu, 5 Feb 2004 16:31:29 +0300
To: dipankar@in.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RCU barrier
In-Reply-To: <20040205132809.GE3703@in.ibm.com>
References: <20040205132809.GE3703@in.ibm.com>
X-Mailer: VM 7.17 under 21.5  (beta16) "celeriac" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma writes:
 > This patch introduces a new interface - rcu_barrier() which waits
 > until all the RCUs queued until this call have been completed.
 > Nikita asked for this quite a while ago for reiser4 jnodes.
 > Sorry Nikita, if you are still using RCU in new reiserfs, 
 > you don't need to use your own logic for this now. Just	
 > call rcu_barrier() during umount.
 > 
 > If Nikita or other users use it, then I would like to push for
 > including this.

Yes, we are still using RCU in the reiser4 (bravely). rcu_barrier()
would allow us to get rid of some really ugly code.

 > 
 > Thanks
 > Dipankar
 > 

Nikita.

