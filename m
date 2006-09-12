Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030246AbWILNlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030246AbWILNlD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 09:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030247AbWILNlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 09:41:03 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:26065 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030246AbWILNlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 09:41:01 -0400
Subject: Re: Spinlock debugging
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sergei Organov <osv@javad.com>
Cc: Andrew Bird <ajb@spheresystems.co.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <87ac55yzx3.fsf@javad.com>
References: <200609111632.27484.ajb@spheresystems.co.uk>
	 <200609111738.21818.ajb@spheresystems.co.uk>
	 <1157995492.23085.191.camel@localhost.localdomain>
	 <200609120847.39655.ajb@spheresystems.co.uk>
	 <1158068628.6780.9.camel@localhost.localdomain>  <87ac55yzx3.fsf@javad.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 12 Sep 2006 15:04:27 +0100
Message-Id: <1158069868.6780.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-09-12 am 17:31 +0400, ysgrifennodd Sergei Organov:
> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> [...]
> > So all you need in your IRQ handler is
> >
> > 	if (tty_insert_flip_string(tty, buf, size))
> > 		tty_flip_buffer_push(tty);
> 
> What is the purpose of the "if" in the above code?  is push with no data
> in the buffer dangerous? Or is it just optimization of
> almost-never-taken path? ;)

Sorry..replied to sender only

It's an optimisation and you are right it may well not even be worth
doing

