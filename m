Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132294AbRAOGJ1>; Mon, 15 Jan 2001 01:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132314AbRAOGJR>; Mon, 15 Jan 2001 01:09:17 -0500
Received: from mailgw.prontomail.com ([216.163.180.10]:17867 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S132294AbRAOGJE>; Mon, 15 Jan 2001 01:09:04 -0500
Message-ID: <3A628A49.7A8E3F69@mvista.com>
Date: Sun, 14 Jan 2001 21:27:37 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: nigel@nrg.org, andrewm@uow.edu.au, linux-kernel@vger.kernel.org,
        linux-audio-dev@ginette.musique.umontreal.ca
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0
In-Reply-To: <200101110519.VAA02784@pizda.ninka.net>
		<Pine.LNX.4.05.10101111233241.5936-100000@cosmic.nrg.org> <14942.9759.730641.804611@pizda.ninka.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> Nigel Gamble writes:
>  > That's why MontaVista's kernel preemption patch uses sleeping mutex
>  > locks instead of spinlocks for the long held locks.
> 
> Anyone who uses sleeping mutex locks is asking for trouble.  Priority
> inversion is an issue I dearly hope we never have to deal with in the
> Linux kernel, and sleeping SMP mutex locks lead to exactly this kind
> of problem.
> 
Exactly why we are going to us priority inherit mutexes.  This handles
the inversion nicely.

George
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
