Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310372AbSCLEuN>; Mon, 11 Mar 2002 23:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310392AbSCLEt7>; Mon, 11 Mar 2002 23:49:59 -0500
Received: from codepoet.org ([166.70.14.212]:18351 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S310372AbSCLEtv>;
	Mon, 11 Mar 2002 23:49:51 -0500
Date: Mon, 11 Mar 2002 21:49:53 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@redhat.com>
Subject: Re: [patch] My AMD IDE driver, v2.7
Message-ID: <20020312044953.GB18857@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0203111916000.18604-100000@penguin.transmeta.com> <Pine.LNX.4.33.0203111944090.18649-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0203111944090.18649-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.4.18-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Mar 11, 2002 at 07:58:32PM -0800, Linus Torvalds wrote:
> If we can really do what sg.c does now, while at the _same_ time also have 
> a "ide-generic" module that uses the exact same infrastructure, then I 
> think I'm happy. Yes, the filtering is bus-specific (because the commands 
> are bus-specific), but the general approach is common.
> 
> Does anybody find any real downsides to this approach or basically trying 
> to abstract sg.c "upwards" a bit?

Essentially, if I understand what you are saying,  you are
looking for a uniform low-level mass-storage layer that does all
the normal low-level drive access stuff.  Presumably, if done
correctly, this would act as a bus-abstracting foundation upon
which the block layer could be built...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
