Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262979AbVGOAjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262979AbVGOAjF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 20:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262944AbVGOAjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 20:39:05 -0400
Received: from ns1.suse.de ([195.135.220.2]:7632 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262979AbVGOAjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 20:39:00 -0400
To: Mark Gross <mgross@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why is 2.6.12.2 less stable on my laptop than 2.6.10?
References: <200507140912.22532.mgross@linux.intel.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 15 Jul 2005 02:38:58 +0200
In-Reply-To: <200507140912.22532.mgross@linux.intel.com.suse.lists.linux.kernel>
Message-ID: <p73wtnsx5r1.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Gross <mgross@linux.intel.com> writes:
> 
> The problem is the process, not than the code.
> * The issues are too much ad-hock code flux without enough disciplined/formal 
> regression testing and review.  

It's basically impossible to regression test swsusp except to release it. 
Its success or failure depends on exactly the driver combination/platform/BIOS
version etc.  e.g. all drivers have to cooperate and the particular
bugs in your BIOS need to be worked around etc. Since that is quite fragile
regressions are common.

However in some other cases I agree some more regression testing
before release would be nice. But that's not how Linux works.  Linux
does regression testing after release.

-Andi
