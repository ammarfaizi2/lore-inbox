Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262209AbVAYW7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262209AbVAYW7z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 17:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbVAYW62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 17:58:28 -0500
Received: from mailfe06.swip.net ([212.247.154.161]:34487 "EHLO
	mailfe06.swip.net") by vger.kernel.org with ESMTP id S262233AbVAYW4c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 17:56:32 -0500
X-T2-Posting-ID: 2Ngqim/wGkXHuU4sHkFYGQ==
Subject: Re: PANIC in check_process_timers() running 2.6.11-rc2-mm1
From: Alexander Nyberg <alexn@dsv.su.se>
To: Roland McGrath <roland@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200501252209.j0PM95MX000477@magilla.sf.frob.com>
References: <200501252209.j0PM95MX000477@magilla.sf.frob.com>
Content-Type: text/plain
Date: Tue, 25 Jan 2005 23:56:13 +0100
Message-Id: <1106693773.705.56.camel@boxen>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks for tracking that down.  It was intended that such things would not
> be possible because getting into that code in the first place should be
> ruled out while exiting.  That removes the requirement for any special case
> check in the common path.  But, it was done too late since it hadn't
> occurred to me that ->live going zero itself created a problem.
> 
> Please try this patch instead of the one you posted.  This patch goes on
> top of all the patches I posted, and so should apply to -mm1 fine.  But
> because the context nearby changes a lot in the various patches, this one
> won't apply after just the cputimers patch without the succeeding three.

Yep, appears to be working fine here and cleaner :-)

