Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275103AbTHRVYq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 17:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275105AbTHRVYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 17:24:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37307 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S275103AbTHRVYo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 17:24:44 -0400
Message-ID: <3F41440D.9020000@pobox.com>
Date: Mon, 18 Aug 2003 17:24:29 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Fix up riscom8 driver to use work queues instead of task queueing.
References: <20030818192529.GC19067@gtf.org>	<Pine.LNX.4.44.0308181234500.5929-100000@home.osdl.org> <20030818133226.66986354.akpm@osdl.org>
In-Reply-To: <20030818133226.66986354.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> pdflush could kinda-sorta be converted to use workqueues, but it doesn't
> want a thread per cpu.


That was another item in the recent thread about workqueues:  other 
kernel code is very suited to the workqueue API, but only needs one 
thread, not a thread per cpu.  Would be nice to have a JUST_ONE_THREAD 
flag to pass to create_workqueue().

I bet adding such a flag would help alleviate some of the "I have 1001 
kthreads on my 16-way" complaints ;-)

	Jeff



