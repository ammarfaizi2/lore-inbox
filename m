Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315302AbSDWRpU>; Tue, 23 Apr 2002 13:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315303AbSDWRpT>; Tue, 23 Apr 2002 13:45:19 -0400
Received: from mx1.elte.hu ([157.181.1.137]:36518 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S315302AbSDWRpS>;
	Tue, 23 Apr 2002 13:45:18 -0400
Date: Tue, 23 Apr 2002 17:41:37 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] task cpu affinity syscalls for 2.4-O(1)
In-Reply-To: <20020423104135.B1904@w-mikek2.des.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.44.0204231739170.17296-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 23 Apr 2002, Mike Kravetz wrote:

> Thanks, I just needed to stare at the migration_thread code a bit more
> to convince myself that all the special cases were covered.

all additional eyeballs are welcome :) The only volatile portion of the
migration concept is the initialization (when there is no migration
mechanizm yet to migrate the migration helper threads ... catch-22), the
actual migration part is much more robust than any previous attempt. (and
we had a fair number of approaches in the O(1) scheduler which were all
pretty intrusive and unrobust.)

	Ingo

