Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263749AbTEYUi6 (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 25 May 2003 16:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263750AbTEYUi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 16:38:58 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:58415 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263749AbTEYUi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 16:38:57 -0400
Date: Sun, 25 May 2003 13:55:32 -0700
From: Andrew Morton <akpm@digeo.com>
To: Alistair J Strachan <alistair@devzero.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-mm9
Message-Id: <20030525135532.244dbbff.akpm@digeo.com>
In-Reply-To: <200305252135.37109.alistair@devzero.co.uk>
References: <200305251619.40137.alistair@devzero.co.uk>
	<20030525131512.45ce0cc2.akpm@digeo.com>
	<200305252135.37109.alistair@devzero.co.uk>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 May 2003 20:52:08.0166 (UTC) FILETIME=[8187A060:01C322FF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair J Strachan <alistair@devzero.co.uk> wrote:
>
> The kernel barfed out the attached junk

oops.  It needs either CONFIG_SMP or CONFIG_DEBUG_SPINLOCK.

I don't know why you hit the final assertion failure in
__journal_remove_journal_head().  Please see if adding
CONFIG_DEBUG_SPINLOCK makes that go away.

