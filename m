Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbUB0BCM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 20:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbUB0BAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 20:00:14 -0500
Received: from holomorphy.com ([199.26.172.102]:26382 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261674AbUB0A6g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 19:58:36 -0500
Date: Thu, 26 Feb 2004 16:58:27 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Jochen Roemling <jochen@roemling.net>
Cc: linux-kernel@vger.kernel.org, Chris Wright <chrisw@osdl.org>
Subject: Re: shmget with SHM_HUGETLB flag: Operation not permitted
Message-ID: <20040227005827.GS693@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jochen Roemling <jochen@roemling.net>, linux-kernel@vger.kernel.org,
	Chris Wright <chrisw@osdl.org>
References: <1tDJX-4Ua-25@gated-at.bofh.it> <1tDJX-4Ua-27@gated-at.bofh.it> <1tDJX-4Ua-29@gated-at.bofh.it> <1tDTE-51P-23@gated-at.bofh.it> <1tDTE-51P-21@gated-at.bofh.it> <403E90DD.9060005@roemling.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403E90DD.9060005@roemling.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27, 2004 at 01:35:41AM +0100, Jochen Roemling wrote:
> Ok. One step further now. The syntax seems correct now. I tried to grant 
> capabilities to the user's shell:
> roesrv01~ # setpcaps cap_ipc_lock+e 2864
> [caps set to:
> = cap_ipc_lock+e
> ]
> Failed to set cap's on process `2864': (Operation not permitted)
> and with the setcap tool again:

This is likely due to not having the capability to grant in the granting
process. Things are supposed to be vauely montonic here.

On Fri, Feb 27, 2004 at 01:35:41AM +0100, Jochen Roemling wrote:
> roesrv01~ # setcap cap_ipc_lock+e a.out
> Failed to set capabilities on file `a.out'
>  (Function not implemented)
> Hmmm. What do we do now?

setcap on executables probably isn't supported by your fs.


-- wli
