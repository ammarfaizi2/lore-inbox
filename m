Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbUGLSZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbUGLSZE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 14:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbUGLSYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 14:24:50 -0400
Received: from [213.146.154.40] ([213.146.154.40]:21202 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261252AbUGLSYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 14:24:40 -0400
Date: Mon, 12 Jul 2004 19:24:31 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@redhat.com>
Cc: Jakub Jelinek <jakub@redhat.com>, davidm@hpl.hp.com,
       suresh.b.siddha@intel.com, jun.nakajima@intel.com,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: serious performance regression due to NX patch
Message-ID: <20040712182431.GB28281@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Jelinek <jakub@redhat.com>,
	davidm@hpl.hp.com, suresh.b.siddha@intel.com,
	jun.nakajima@intel.com, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <200407100528.i6A5SF8h020094@napali.hpl.hp.com> <Pine.LNX.4.58.0407110437310.26065@devserv.devel.redhat.com> <Pine.LNX.4.58.0407110536130.2248@devserv.devel.redhat.com> <Pine.LNX.4.58.0407110550340.4229@devserv.devel.redhat.com> <20040711123803.GD21264@devserv.devel.redhat.com> <Pine.LNX.4.58.0407121402160.2451@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0407121402160.2451@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2004 at 02:08:11PM -0400, Ingo Molnar wrote:
> the #ifdef could be made an arch inline or define. But it's really
> academic as only ia64 seems to have this problem. So i'd suggest the patch
> below.

Well, it's not.  We probably want each new port start to have the ia64
behaviour, so it should be abstracted out nicer.

