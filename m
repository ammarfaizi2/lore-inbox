Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbWFZDSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWFZDSI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 23:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbWFZDSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 23:18:07 -0400
Received: from web50412.mail.yahoo.com ([206.190.38.155]:45961 "HELO
	web50412.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751328AbWFZDSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 23:18:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=3XBiwqYXTt3Ii9fk1jG99QuvAY91m+iGIIVJPgkClRzLTgshYcR/mb4hPLMWb6tP1Cezdv3mi1sJ2+uCOdpN9oTqSiJOKHKFYRZpAHRNUXj9G/FXmrMnZnOk2b8+Gp121J/md7yHcjVxfcqvvofUA7W9iTU+KIC9UUFB5jOVsBw=  ;
Message-ID: <20060626031805.41634.qmail@web50412.mail.yahoo.com>
Date: Sun, 25 Jun 2006 20:18:05 -0700 (PDT)
From: Alex Davis <alex14641@yahoo.com>
Subject: Re: [PATCH] Fix bug: accessing past end of array.
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, scsi <linux-scsi@vger.kernel.org>
In-Reply-To: <20060625192827.730f1a8d.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- "Randy.Dunlap" <rdunlap@xenotime.net> wrote:

> [adding linux-scsi]
> 
> On Sun, 25 Jun 2006 19:06:46 -0700 (PDT) Alex Davis wrote:
> 
> > If the card is re-inserted 2 or more times, we access elements
> > past the end of the aha152x_host array.
> 
> When I was testing/reproducing this, I observed that removing
> the card did not cause the aha152x_detach() function to be called
> (in drivers/scsi/pcmcia/aha152x_stub.c).  However, I didn't
> find out why that doesn't happen.  I think fixing this would
> be a big help.
> 
Strange. I'm not having that problem. I even added a printk to verify.
I get the following in my logs:

[4295091.671000] pccard: card ejected from slot 0
[4295091.671000] aha152x_detach(0xd8877600)       <-----added printk.



> > Also correct spelling errors.
> > 
> > This is for 2.6.17.
> > 
> > Signed-off-by Alex Davis <alex14641 at yahoo dot com>
> > =========================================================================
> > diff -u linux-2.6.17.1-orig/drivers/scsi/aha152x.c linux-2.6.17.1/drivers/scsi/aha152x.c
[snip]

I code, therefore I am

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
