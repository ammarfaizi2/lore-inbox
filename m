Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262783AbSJLCvI>; Fri, 11 Oct 2002 22:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262786AbSJLCvI>; Fri, 11 Oct 2002 22:51:08 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16914 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262783AbSJLCvI>; Fri, 11 Oct 2002 22:51:08 -0400
Date: Fri, 11 Oct 2002 19:58:46 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Chris Wright <chris@wirex.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.41 capget fix
In-Reply-To: <20021010144715.A30806@figure1.int.wirex.com>
Message-ID: <Pine.LNX.4.44.0210111954280.5671-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Oct 2002, Chris Wright wrote:
> 
> The patch below fixes my oversight.  The locking is left the way it was,
> and just the pid 0 part is fixed as well as the duplicate code removed.

All right, call me stupid, but twhere is the "duplication" in the code you 
removed?

I see the "security/capability.c" thing, yes, but I also look at
"security/dummy.c", and it appears that at least for that case nobody
would ever initialize the capabilities that we return to user space at
all.

So there's a bug somewhere there, and removing the duplication makes 
things worse (admittedly for a case which isn't enabled in the regular 
kernel, but still..)

So I'd ask you to have patience with me, and send a third patch that gets 
this thing right too.. 

		Linus

