Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030215AbWILNbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbWILNbn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 09:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbWILNbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 09:31:43 -0400
Received: from javad.com ([216.122.176.236]:8711 "EHLO javad.com")
	by vger.kernel.org with ESMTP id S1030215AbWILNbm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 09:31:42 -0400
From: Sergei Organov <osv@javad.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Bird <ajb@spheresystems.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: Spinlock debugging
References: <200609111632.27484.ajb@spheresystems.co.uk>
	<200609111738.21818.ajb@spheresystems.co.uk>
	<1157995492.23085.191.camel@localhost.localdomain>
	<200609120847.39655.ajb@spheresystems.co.uk>
	<1158068628.6780.9.camel@localhost.localdomain>
Date: Tue, 12 Sep 2006 17:31:20 +0400
In-Reply-To: <1158068628.6780.9.camel@localhost.localdomain> (Alan Cox's
	message of "Tue, 12 Sep 2006 14:43:48 +0100")
Message-ID: <87ac55yzx3.fsf@javad.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
[...]
> So all you need in your IRQ handler is
>
> 	if (tty_insert_flip_string(tty, buf, size))
> 		tty_flip_buffer_push(tty);

What is the purpose of the "if" in the above code?  is push with no data
in the buffer dangerous? Or is it just optimization of
almost-never-taken path? ;)

-- Sergei.
