Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288963AbSAFOtD>; Sun, 6 Jan 2002 09:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288964AbSAFOso>; Sun, 6 Jan 2002 09:48:44 -0500
Received: from [217.9.226.246] ([217.9.226.246]:49537 "HELO
	merlin.xternal.fadata.bg") by vger.kernel.org with SMTP
	id <S288963AbSAFOsn>; Sun, 6 Jan 2002 09:48:43 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: mumismo@wanadoo.es (Jordi), torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: 2.5.1pre9 change several if (x) BUG to BUG_ON(x)
In-Reply-To: <E16NEar-0005Ln-00@the-village.bc.nu>
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <E16NEar-0005Ln-00@the-village.bc.nu>
Date: 06 Jan 2002 16:48:46 +0200
Message-ID: <878zbba629.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>> Yes, only that, even a trained monkey is able to make this patch, but i think
>> is a good way to make people confortable with BUG_ON

Alan> Your patch looks wrong (ook ook! 8)) - if you build without BUG enabled you
Alan> don't make various function calls with your change. BUG_ON has the C nasty
Alan> assert() does that makes it a horrible horrible idea and its unfortunate
Alan> it got put in.

Alan> 	BUG_ON(function(x,y))

#ifdef DEBUG
#define BUG_ON(x) if (x) BUG()
#else
#define BUG_ON(x) (void)(x)
#endif
