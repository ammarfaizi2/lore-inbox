Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261834AbULJWGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbULJWGR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 17:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbULJWGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 17:06:16 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:7386 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261834AbULJWGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 17:06:11 -0500
Subject: Re: SO_RCVLOWAT option to socket()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rob Sanders <rarob@comcast.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E6D51930-4A60-11D9-9C95-000A95A6FC34@comcast.net>
References: <E6D51930-4A60-11D9-9C95-000A95A6FC34@comcast.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1102712550.3201.70.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 10 Dec 2004 21:02:32 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-12-10 at 04:06, Rob Sanders wrote:
> Hey y'all,
>     Can anyone point me to a resource for why SO_RCVLOWAT is hardcoded 
> to 1 in linux?

The 1003.1g drafts require it is supported.

> If you are using select or poll with timeouts it would be less costly 
> to have the kernel tell you
> when all of the data you reqested (via SO_RCVLOWAT) is ready to be read 

But is the cost of all those special case checks and all the handling
for
it such as select computing if enough tcp packets together accumulated
worth
the cost on every app not using LOWAT for the microscopic gain given
that
essentially nobody uses it.

Alan

