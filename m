Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbUL1R2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbUL1R2y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 12:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbUL1R2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 12:28:54 -0500
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:53079 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261200AbUL1R2d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 12:28:33 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: PATCH: 2.6.10 - Misrouted IRQ recovery for review
Date: Tue, 28 Dec 2004 12:28:27 -0500
User-Agent: KMail/1.6.2
Cc: Arjan van de Ven <arjan@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, mingo@redhat.com
References: <1104249508.22366.101.camel@localhost.localdomain> <1104253919.4173.11.camel@laptopd505.fenrus.org>
In-Reply-To: <1104253919.4173.11.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <200412281228.27307.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 December 2004 12:11 pm, Arjan van de Ven wrote:
> On Tue, 2004-12-28 at 15:58 +0000, Alan Cox wrote:
> > Ported to the new kernel/irq code.
> 
> 
> one question; I see you start passing a struct pt_regs around all over
> the place; does *anything* actually use that animal, or should we
> consider just passing a NULL .....
> (and eventually in 2.7 remove the parameter entirely from irq handlers?)
> 

>From what I saw the only thing that presently uses pt_rergs is SysRq
handler to print the call trace and if we slightly change the semantics
(instead of printing the trace immediately raise a flag and when next
interrupt arrives check it in do_IRQ and print the trace from there -
I even had some patches) we could drop pt_regs. I would very much like
to do so at least for input drivers.

-- 
Dmitry
