Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbVBCXJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVBCXJT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 18:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbVBCXFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 18:05:03 -0500
Received: from fw.osdl.org ([65.172.181.6]:54943 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262833AbVBCXAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 18:00:51 -0500
Date: Thu, 3 Feb 2005 15:05:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: torvalds@osdl.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, jlan@sgi.com
Subject: Re:
 move-accounting-function-calls-out-of-critical-vm-code-paths.patch
Message-Id: <20050203150551.4d88f210.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0502031436460.26183@schroedinger.engr.sgi.com>
References: <20050110184617.3ca8d414.akpm@osdl.org>
	<Pine.LNX.4.58.0502031319440.25268@schroedinger.engr.sgi.com>
	<20050203140904.7c67a144.akpm@osdl.org>
	<Pine.LNX.4.58.0502031436460.26183@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> I hope that Roland's changes for higher resolution of cputime would
> make that possible. But this is Jay's thing not mine. I just want to make
> sure that the CSA patches does not get in the way of our attempts to
> improve the performance of the page fault handler. In the discussions on
> linux-mm there was also some concern about adding these calls.

Well your patch certainly cleans things up in there and would be a good
thing to have as long as we can be sure that it doesn't break the
accounting in some subtle way.

Which implies that we need to see some additional accounting code, so we
can verify that the base accumulation infrastructure is doing the expected
thing.  As well as an ack from the interested parties.  Does anyone know
what's happening with all the new accounting initiatives?  I'm seeing no
activity at all.

