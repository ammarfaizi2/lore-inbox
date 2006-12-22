Return-Path: <linux-kernel-owner+w=401wt.eu-S1752476AbWLVUEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476AbWLVUEu (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 15:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752526AbWLVUEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 15:04:50 -0500
Received: from smtp.osdl.org ([65.172.181.25]:41180 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752476AbWLVUEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 15:04:49 -0500
Date: Fri, 22 Dec 2006 12:04:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] change WARN_ON back to "BUG: at ..."
Message-Id: <20061222120422.eb28953b.akpm@osdl.org>
In-Reply-To: <20061221235732.GA32637@elte.hu>
References: <20061221124327.GA17190@elte.hu>
	<458AD71D.2060508@goop.org>
	<20061221235732.GA32637@elte.hu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've always felt that it is wrong (or at least misleading) that WARN_ON
prints "BUG".  It would have been better if it had said "WARNING", and only
BUG_ON says "BUG".

But lots of people have now written downstream log-parsing tools which
might break due to this change, so I'm inclined to go with Ingo's patch,
and restore the old (il)logic.

