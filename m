Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422856AbWJLQFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422856AbWJLQFw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 12:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422855AbWJLQFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 12:05:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26797 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422856AbWJLQFv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 12:05:51 -0400
Date: Thu, 12 Oct 2006 17:05:15 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Alasdair G Kergon <agk@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       Heinz Mauelshagen <mauelshagen@redhat.com>
Subject: Re: dm stripe: Fix bounds
Message-ID: <20061012160515.GD17654@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Phillip Susi <psusi@cfl.rr.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org,
	Heinz Mauelshagen <mauelshagen@redhat.com>
References: <20060316151114.GS4724@agk.surrey.redhat.com> <452DBE11.2000005@cfl.rr.com> <20061012135945.GV17654@agk.surrey.redhat.com> <452E5FD0.8060309@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452E5FD0.8060309@cfl.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2006 at 11:31:28AM -0400, Phillip Susi wrote:
> The correct thing to do is for dm to 
> accept the values and work properly.

But there's ambiguity: should dm truncate just the last stripe(s) or all
stripes equally, or use some other combination of truncation?  The answer
depends on the circumstances, and so it is for userspace, which should know
which of those is required, to resolve the matter by supplying appropriate
chunk sizes.

Alasdair
-- 
agk@redhat.com
