Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291293AbSBMBbZ>; Tue, 12 Feb 2002 20:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291291AbSBMBbS>; Tue, 12 Feb 2002 20:31:18 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:28940 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S291282AbSBMBbC>; Tue, 12 Feb 2002 20:31:02 -0500
Message-ID: <3C69C1BD.CB57A57C@linux-m68k.org>
Date: Wed, 13 Feb 2002 02:30:37 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: pavel@suse.cz, davidm@hpl.hp.com, anton@samba.org,
        linux-kernel@vger.kernel.org
Subject: Re: thread_info implementation
In-Reply-To: <15464.34183.282646.869983@napali.hpl.hp.com>
		<20020211.190449.55725714.davem@redhat.com>
		<20020212171421.GE148@elf.ucw.cz> <20020212.164636.21927297.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

"David S. Miller" wrote:

>    So you essentially made your cache one cacheline smaller.
> 
> Not at all, that cacheline has to be in the cache anyways because
> it also holds all the other information which needs to be accessed
> during trap entry/exit.
> 
> Try again.

Larger code size due to the extra load?
At least two cache lines needed for any access to task_struct?
David, what are you trying to prove? Any architecture which has a thread
register prefers to access data directly through this register and it's
not really difficult to avoid this indirection, that might be needed on
ia32.

bye, Roman
