Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261805AbVEJVPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbVEJVPP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 17:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbVEJVPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 17:15:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33479 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261790AbVEJVNE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 17:13:04 -0400
Date: Tue, 10 May 2005 14:12:58 -0700
Message-Id: <200505102112.j4ALCwXN002849@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Olivier Croquette <ocroquette@free.fr>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org, alexn@dsv.su.se, mingo@elte.hu
Subject: Re: Scheduler: SIGSTOP on multi threaded processes
In-Reply-To: Olivier Croquette's message of  Tuesday, 10 May 2005 22:59:33 +0200 <428120B5.5060403@free.fr>
X-Zippy-Says: Thousands of days of civilians ...  have produced a...  feeling for
   the aesthetic modules --
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - Can a SIGSTOP be in a pending state in Linux?

For short periods.

> - If kill(SIGSTOP,...) returns, does that mean that the corresponding 
> process is completly suspended?

No.  One or more threads of the process may still be running on another CPU
momentarily before they process the interrupt and stop for the signal.
