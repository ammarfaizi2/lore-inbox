Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030436AbVLGXPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030436AbVLGXPR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 18:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751819AbVLGXPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 18:15:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53139 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751816AbVLGXPP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 18:15:15 -0500
Date: Wed, 7 Dec 2005 15:15:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Martin Hicks <mort@bork.org>
Cc: wfg@mail.ustc.edu.cn, linux-kernel@vger.kernel.org
Subject: Re: mm: fold sc.may_writepage and sc.may_swap into sc.flags
Message-Id: <20051207151559.090c356f.akpm@osdl.org>
In-Reply-To: <20051207170226.GB3085@bork.org>
References: <20051207104755.177435000@localhost.localdomain>
	<20051207105154.142779000@localhost.localdomain>
	<20051207111501.GA8133@mail.ustc.edu.cn>
	<20051207170226.GB3085@bork.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Hicks <mort@bork.org> wrote:
>
> On Wed, Dec 07, 2005 at 07:15:01PM +0800, Wu Fengguang wrote:
> > Fold bool values into flags to make struct scan_control more compact.
> > 
> 
> I suspect that the may_swap flag is still a left over from my failed
> attempt at zone_reclaim.  It should be removed.

Yes, it can be removed, thanks.  I missed that.  (Patch
`kill-last-zone_reclaim-bits.patch' in -mm updated).
