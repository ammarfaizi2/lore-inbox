Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262437AbUCCLVZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 06:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262440AbUCCLVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 06:21:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43965 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262437AbUCCLVX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 06:21:23 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16453.49072.809252.290117@neuro.alephnull.com>
Date: Wed, 3 Mar 2004 06:21:20 -0500
From: Rik Faith <faith@redhat.com>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Christoph Hellwig <hch@infradead.org>, okir@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Light-weight Auditing Framework
In-Reply-To: [Muli Ben-Yehuda <mulix@mulix.org>] Wed  3 Mar 2004 10:55:01 +0200
References: <16451.25789.72815.763592@neuro.alephnull.com>
	<20040301194501.A9080@infradead.org>
	<16451.40189.997259.379123@neuro.alephnull.com>
	<20040303085501.GC31052@mulix.org>
X-Key: 7EB57214; 958B 394D AD29 257E 553F  E7C7 9F67 4BE0 7EB5 7214
X-Url: http://www.redhat.com/
X-Mailer: VM 7.17; XEmacs 21.4; Linux 2.4.22-1.2163.nptl (neuro)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed  3 Mar 2004 10:55:01 +0200, Muli Ben-Yehuda <mulix@mulix.org> wrote:
> I'd like to second the sentiment - for syscalltrack, we would love to
> have a framework that can be used for debugging system call events. 

I should clarify to avoid any confusion.  The audit framework I am
proposing does _not_ allow for generic hooking of system calls.

However, the ability to audit the call is generic in the sense that
another part of the kernel can request that an audit record be generated
for the current in-progress system call (or filtering can be used to
request that audit records be generated).  Although this should be
sufficient for SELinux and other security infrastructures, as well as
many non-security uses, it would only support a subset of what
syscalltrack can do currently (i.e., audit can provide information about
the syscall, but can't be used to change the behavior of the syscall).

