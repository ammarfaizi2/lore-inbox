Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932559AbVKAFzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559AbVKAFzh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 00:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbVKAFzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 00:55:37 -0500
Received: from smtp103.sbc.mail.re2.yahoo.com ([68.142.229.102]:26001 "HELO
	smtp103.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751180AbVKAFzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 00:55:36 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Ian Wienand <ianw@gelato.unsw.edu.au>
Subject: Re: [PATCH] Convert dmasound_awacs to dynamic input_dev allocation
Date: Tue, 1 Nov 2005 00:55:31 -0500
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <20051101020329.GA7773@cse.unsw.EDU.AU> <200511010014.57026.dtor_core@ameritech.net> <20051101055052.GA16672@cse.unsw.EDU.AU>
In-Reply-To: <20051101055052.GA16672@cse.unsw.EDU.AU>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511010055.32726.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 November 2005 00:50, Ian Wienand wrote:
> On Tue, Nov 01, 2005 at 12:14:56AM -0500, Dmitry Torokhov wrote:
> > It seems that the change is pretty straightforward... Could you please try
> > this one?
> 
> Ahh, ok!  I thought that that comment meant it was deliberately
> ignoring the return of input_register_device (by which time it's got
> memory, irq's, io, etc), but now I see it's void anyway.  So why not
> just move the setup right to the top?
>

Now you are leaking memory if something else fails... FOr example when
chip is not present.


-- 
Dmitry
