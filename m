Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262288AbVEMPnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbVEMPnG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 11:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262400AbVEMPnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 11:43:05 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:18939 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S262288AbVEMPlW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 11:41:22 -0400
In-Reply-To: <4284C9A7.7010400@fujitsu-siemens.com>
Subject: Re: Again: UML on s390 (31Bit)
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: linux-kernel@vger.kernel.org, Ulrich Weigand <uweigand@de.ibm.com>
X-Mailer: Lotus Notes Build V651_12042003 December 04, 2003
Message-ID: <OFDFABA6D8.CD5E92EF-ONC1257000.0055D4CD-C1257000.00561400@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Fri, 13 May 2005 17:40:12 +0200
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 13/05/2005 17:41:20
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> BTW: I still can't see any loop in the kernel, that could call
> do_signal() multiple times without returning to user in between.
> For my understanding: do I miss something? If so, where is the loop?

do_signal sets up a signal frame for the user. It returns from it
by an svc and then another signal could be pending. It's not really
a loop. For every signal frame you end up at least once in user space
because we avoid creating multiple signal frames on the user stack.

blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH


