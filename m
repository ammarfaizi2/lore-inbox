Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965090AbWIECSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965090AbWIECSa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 22:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965091AbWIECSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 22:18:30 -0400
Received: from web36706.mail.mud.yahoo.com ([209.191.85.40]:3479 "HELO
	web36706.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965090AbWIECS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 22:18:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Bc4yPJ2SUZMac1zoHl4/ZvIbztljNa9Jo/U9ipl00LZp685i1V4/ulQgWLU/q4hrysvGUPj8WWR5jOtlCHYIjKCuMHYBr/TRB3GKAWOdk8/koHoiTck0/JM449eAatL9ChE5/w4cZ1jnckCCnsVzmWSCNtkkQ4TTR50qflBPx50=  ;
Message-ID: <20060905021828.13099.qmail@web36706.mail.mud.yahoo.com>
Date: Mon, 4 Sep 2006 19:18:28 -0700 (PDT)
From: Alex Dubov <oakad@yahoo.com>
Subject: Re: Support for TI FlashMedia (pci id 104c:8033, 104c:803b) flash card readers
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44FC3B2E.106@drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Pierre Ossman <drzeus-list@drzeus.cx> wrote:
> > 2. for write operation, error-less BUSY assert/de-assert pairs shall be counted instead
> > Currently I only look at the last BUSY de-assert to verify that command is completed
> successfully.
> > As mmc_block always issues single block writes it is sufficient. If this will ever change,
> more
> > sophisticated scheme can be devised.
> >
> >   
> 
> This is about to change. Hence the need to check that all drivers are
> reporting what they're supposed to.
> 
I'll put in the code for this today.

I also got a bug report from one of my users. Formerly, I used fixed timeout for data transfer,
but now I'm setting a timeout from data->timeout_clks. This causes recurrent timeouts with some
cards. Have you encountered this problem before? If yes, what will be the preferred solution?

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
