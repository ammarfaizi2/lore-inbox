Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266817AbUFZFKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266817AbUFZFKK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 01:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266930AbUFZFKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 01:10:10 -0400
Received: from palrel12.hp.com ([156.153.255.237]:41660 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S266817AbUFZFKF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 01:10:05 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16605.1322.355489.223220@napali.hpl.hp.com>
Date: Fri, 25 Jun 2004 22:10:02 -0700
To: Andrew Morton <akpm@osdl.org>
Cc: Jack Steiner <steiner@sgi.com>, davidm@hpl.hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] - Reduce TLB flushing during process migration
In-Reply-To: <20040623143318.07932255.akpm@osdl.org>
References: <20040623143844.GA15670@sgi.com>
	<20040623143318.07932255.akpm@osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 23 Jun 2004 14:33:18 -0700, Andrew Morton <akpm@osdl.org> said:

  Andrew> Jack Steiner <steiner@sgi.com> wrote:

  >> This patch adds a platform specific hook to allow an arch-specific
  >> function to be called after an explicit migration.

  Andrew> OK by me.  David, could you please merge this up?

  Andrew> Jack, please prepare an update for Documentation/cachetlb.txt.

Jack, could you send me an updated patch which has all the revisions requested?
Also, my preference would be for tlb_migrate_finish() to be a true no-op
(not a call to a no-op function) when compiling for a platform that
doesn't need this hook.  Could you look into this?

Thanks,

	--david
