Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132668AbRC2EIZ>; Wed, 28 Mar 2001 23:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132672AbRC2EIP>; Wed, 28 Mar 2001 23:08:15 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:25613 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132668AbRC2EII>; Wed, 28 Mar 2001 23:08:08 -0500
Subject: Re: Hangs under 2.4.2-ac{18,19,24} that do not happen under -ac12.
To: pwc@sgi.com (Paul Cassella)
Date: Thu, 29 Mar 2001 05:10:05 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SGI.3.96.1010328165432.10707A-100000@fsgi626.americas.sgi.com> from "Paul Cassella" at Mar 28, 2001 05:08:36 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14iTlA-000747-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have had hangs under 2.4.2-ac18, -ac19, and -ac24, after uptimes of
> 36 hours, 12 hours, and 10 hours, respectively.  -ac12 has twice run
> for a week without crashing.  I didn't see anything in the later -ac
> changelogs that looks responsible, but I haven't actually tried them.

Was anything between 12 and 18 stable ?

> A few lines earlier in this function, inode->i_op->truncate() is called
> without lock_kernel().  Should it also have a lock_kernel(), or is it not
> needed there? 

Absolutely correct. The lock is missing. Bizarrely Al Viro just noticed this
about 15 minutes ago


