Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271428AbUJVQUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271428AbUJVQUF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 12:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271432AbUJVQUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 12:20:04 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:48319 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S271428AbUJVQS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 12:18:59 -0400
Date: Fri, 22 Oct 2004 18:19:33 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Rik van Riel <riel@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, shaggy@austin.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] zap_pte_range should not mark non-uptodate pages dirty
Message-ID: <20041022161933.GG14325@dualathlon.random>
References: <20041022004159.GB14325@dualathlon.random> <Pine.LNX.4.44.0410212250500.13944-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0410212250500.13944-100000@chimarrao.boston.redhat.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 10:51:34PM -0400, Rik van Riel wrote:
> That depends on the filesystem.  I hope the clustered filesystems

I agree if you do a "is_underlying_fs_GFS?" check then you can make more
assumptions.

But if you don't do that, the linux API always left undefined the
mmapped contents after O_DIRECT writes on the mmapped data.

