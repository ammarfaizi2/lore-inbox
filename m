Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131579AbQLMPMz>; Wed, 13 Dec 2000 10:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131600AbQLMPMt>; Wed, 13 Dec 2000 10:12:49 -0500
Received: from terminus.zytor.com ([209.10.217.84]:9740 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP
	id <S131579AbQLMPMc>; Wed, 13 Dec 2000 10:12:32 -0500
Message-ID: <2741.194.236.209.133.976716626.squirrel@www.zytor.com>
Date: Wed, 13 Dec 2000 06:10:26 -0800 (PST)
Subject: Re: [PATCH] setup.c notsc Re: Microsecond accuracy
From: "H. Peter Anvin" <hpa@zytor.com>
To: hugh@veritas.com
In-Reply-To: <Pine.LNX.4.21.0012071856280.1138-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.21.0012071856280.1138-100000@localhost.localdomain>
Cc: macro@ds2.pg.gda.pl, hpa@zytor.com, linux-kernel@vger.kernel.org
X-Mailer: SquirrelMail (version 0.5)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> The present situation is inconsistent: "notsc" removes cpuinfo's
> "tsc" flag in the UP case (when cpu_data[0] is boot_cpu_data), but
> not in the SMP case.  I don't believe HPA's recent mods affected that
> behaviour, but it is made consistent (cleared in SMP case too) by the
> patch I sent him a couple of days ago, below updated for test12-pre7...
> 

Great.  You've taken something that was somewhat broken in the UP case and 
introduced massive braindamage in the SMP case.  What really needs to be is 
that the global enables (boot_cpu_data) should be exposed.

    -hpa




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
