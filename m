Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968643AbWLETO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968643AbWLETO7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 14:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968645AbWLETO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 14:14:58 -0500
Received: from nz-out-0506.google.com ([64.233.162.224]:43108 "EHLO
	nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S968643AbWLETO5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 14:14:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=glYubgeTTdb3AyBetfNG0rudwIeFs3j+AiJ1K7dA/WSmfdQhsbf+ZzzFrIurzfIY3XRadZOUZ2qcC8OufZ5zVX62Xsn4eyXU2LEUT8aTSecV0iEXOg3QtwihK26vGhMyKYArUqBck+y1AvQpdzhjZfJomOxmBymPyLi90EsgFD0=
Message-ID: <5d96567b0612051114m21266529v779e34ffc492fc5e@mail.gmail.com>
Date: Tue, 5 Dec 2006 21:14:56 +0200
From: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: irq/0/smp_affinity =3 doesn't seem to work
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <1165336346.3233.382.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5d96567b0612050830s1b0c0708s3f796d85227f1285@mail.gmail.com>
	 <1165336346.3233.382.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/06, Arjan van de Ven <arjan@infradead.org> wrote:
> On Tue, 2006-12-05 at 18:30 +0200, Raz Ben-Jehuda(caro) wrote:
> > hello.
> >
> > I have a dual cpu AMD machine, I noticed that
> > only one timer0 is working in /proc/interrutps.
> > setting proc/irq/0/smp_affinity to 3 does make
> > any difference.
>
> if you set it to 3 then the chipset gets to decide where the irq goes.
> Many decide to send it to the first cpu.
>
> (not that it matters, the timer is so low frequency that it can go
> anywhere without problems)
>
> --
> if you want to mail me at work (you don't), use arjan (at) linux.intel.com
> Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org
>
>
thanks Arjan.

Yet something is not clear to me.
To the best of my knowledge , each cpu run its own schedule routine.
So, if only cpu0 gets timer0 interrupts, how does cpu1
gets to run the schedule function ?
what interrupts cpu1' current task  ?

raz
