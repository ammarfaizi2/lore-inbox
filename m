Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267654AbTBLVtN>; Wed, 12 Feb 2003 16:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267656AbTBLVtN>; Wed, 12 Feb 2003 16:49:13 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:56688 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S267654AbTBLVtM>; Wed, 12 Feb 2003 16:49:12 -0500
Date: Wed, 12 Feb 2003 13:58:54 -0800
Message-Id: <200302122158.h1CLwsM24601@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: another subtle signals issue
In-Reply-To: Linus Torvalds's message of  Wednesday, 12 February 2003 13:19:56 -0800 <Pine.LNX.4.44.0302121318250.1096-100000@penguin.transmeta.com>
X-Fcc: ~/Mail/linus
X-Shopping-List: (1) Inquisitive abolitionists
   (2) Subatomic soil skis
   (3) Mix 'n' Match Instant enema picnics
   (4) Fastidious trout
   (5) Chimerical pencils
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yeah. There's another issue too, which is the "preferred thread" thing. We 
> should probably _prefer_ threads that are interruptible as opposed to 
> threads that are in disk wait, the same way we prefer threads that are not 
> stopped. It might improve throughput.

I am really only concerned with the correctness issues, and don't have much
opinion on optimization choices like this.  It think the tradeoffs on who
it give it to vs the complexity of the scan and such depend heavily on how
many threads you have and what they are doing.
