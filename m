Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264013AbRFEPbR>; Tue, 5 Jun 2001 11:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264014AbRFEPbH>; Tue, 5 Jun 2001 11:31:07 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:57314 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S264013AbRFEPbC>;
	Tue, 5 Jun 2001 11:31:02 -0400
Message-ID: <3B1CFB31.ABC11036@mandrakesoft.com>
Date: Tue, 05 Jun 2001 11:30:57 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Shawn Starr <spstarr@sh0n.net>
Cc: George Bonser <george@gator.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.6-pre1 unresolved symbols
In-Reply-To: <Pine.LNX.4.30.0106051123270.142-100000@coredump.sh0n.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn Starr wrote:
> 
> I have noticed unresolves symbols for the netfilter modules. this occurs
> durning depmod -a.

Note they are the same unresolved symbol.

Ingo Molnar has posted a patch for this, entitled
	[patch] softirq-2.4.6-B4

or you can edit kernel/ksyms.c yourself, and add the lines

	EXPORT_SYMBOL(do_softirq);
	EXPORT_SYMBOL(tasklet_schedule);
	EXPORT_SYMBOL(tasklet_hi_schedule);

-- 
Jeff Garzik      | An expert is one who knows more and more about
Building 1024    | less and less until he knows absolutely everything
MandrakeSoft     | about nothing.
