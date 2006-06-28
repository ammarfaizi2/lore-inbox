Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932846AbWF1PqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932846AbWF1PqH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 11:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932847AbWF1PqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 11:46:07 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:45198 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932846AbWF1PqG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 11:46:06 -0400
Message-ID: <005e01c69ac9$a55e1bf0$6f00a8c0@comcast.net>
From: "John Hawkes" <hawkes@sgi.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Cc: "Tony Luck" <tony.luck@gmail.com>, "Andrew Morton" <akpm@osdl.org>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       "Jack Steiner" <steiner@sgi.com>, "Dan Higgins" <djh@sgi.com>,
       "Jeremy Higdon" <jeremy@sgi.com>
References: <20060627220139.3168.69409.sendpatchset@tomahawk.engr.sgi.com> <1151483994.3153.5.camel@laptopd505.fenrus.org>
Subject: Re: [PATCH] ia64: change usermode HZ to 250
Date: Wed, 28 Jun 2006 08:43:46 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Arjan van de Ven" <arjan@infradead.org>
...
> ok why not define the userspace HZ to
>
> #define HZ sysconf(_SC_CLK_TCK)

That did occur to me.  It obviously does get the correct value.  The downside
is that one of those crufty apps that thinks it is using "HZ" as a constant
will instead be invoking a more costly syscall.  Should we care about the
resulting performance impact?

I vote for Arjan's solution.

John Hawkes

