Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263638AbTEDPgQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 11:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263639AbTEDPgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 11:36:16 -0400
Received: from ns.suse.de ([213.95.15.193]:53260 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263638AbTEDPgL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 11:36:11 -0400
To: Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Announcement] "Exec Shield", new Linux security feature
References: <Pine.LNX.4.44.0305040404300.12757-100000@devserv.devel.redhat.com.suse.lists.linux.kernel>
	<Pine.LNX.4.44.0305040448250.24497-100000@devserv.devel.redhat.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 04 May 2003 17:48:39 +0200
In-Reply-To: <Pine.LNX.4.44.0305040448250.24497-100000@devserv.devel.redhat.com.suse.lists.linux.kernel>
Message-ID: <p73issq1zmw.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@redhat.com> writes:

> 
> ie. if the binary anywhere has code that does:
> 
> 	system("/bin/sh")

You just need system(char *arg) { ... } (= in every libc). Then put /bin/sh somewhere and 
a pointer to it on the stack as argument and overwrite some return address on the 
stack to jump to it.

-Andi
