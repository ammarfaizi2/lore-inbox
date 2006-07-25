Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbWGYAIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWGYAIP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 20:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWGYAIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 20:08:14 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:13771 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S932343AbWGYAIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 20:08:14 -0400
Date: Mon, 24 Jul 2006 20:08:12 -0400
To: Josh Triplett <josht@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] [coda] Remove incorrect unlock_kernel from allocation failure path in coda_open
Message-ID: <20060725000812.GJ26153@delft.aura.cs.cmu.edu>
Mail-Followup-To: Josh Triplett <josht@us.ibm.com>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <1153776238.4931.11.camel@josh-work.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153776238.4931.11.camel@josh-work.beaverton.ibm.com>
User-Agent: Mutt/1.5.11+cvs20060403
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2006 at 07:29:24PM -0400, Josh Triplett wrote:
> Commit 398c53a757702e1e3a7a2c24860c7ad26acb53ed (in the historical GIT tree)
> moved the lock_kernel() in coda_open after the allocation of a coda_file_info
> struct, but left an unlock_kernel() in the allocation failure error path;
> remove it.
> 
> Signed-off-by: Josh Triplett <josh@freedesktop.org>

Acked-by: Jan Harkes <jaharkes@cs.cmu.edu>

---

Totally correct fix, I actually thought I already sent a patch for the
same problem upstream. I should dig through my local trees to check if
anything else fell through the cracks.

Jan
