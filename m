Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135821AbRDTHuz>; Fri, 20 Apr 2001 03:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135824AbRDTHup>; Fri, 20 Apr 2001 03:50:45 -0400
Received: from t2.redhat.com ([199.183.24.243]:56307 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S135821AbRDTHuj>; Fri, 20 Apr 2001 03:50:39 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generic rw_semaphores, compile warnings patch 
In-Reply-To: Your message of "Thu, 19 Apr 2001 16:43:52 PDT."
             <15071.30776.914468.900710@pizda.ninka.net> 
Date: Fri, 20 Apr 2001 08:50:38 +0100
Message-ID: <24459.987753038@warthog.cambridge.redhat.com>
From: David Howells <dhowells@cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller <davem@redhat.com> wrote:
> D.W.Howells writes:
>  > This patch (made against linux-2.4.4-pre4) gets rid of some warnings obtained 
>  > when using the generic rwsem implementation.
>
> Have a look at pre5, this is already fixed.

Not entirely so...

There's also a missing "struct rw_semaphore;" declaration in linux/rwsem.h. It
needs to go in the gap below "#include <linux/wait.h>". Otherwise the
declarations for the contention handling functions will give warnings about
the struct being declared in the parameter list.

David
